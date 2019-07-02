//
//  RegisterViewModel.swift
//  ViewModels
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Models

public class RegisterViewModel {
    let disposeBag = DisposeBag()
    let verification: Variable<String> = Variable("")
    let COUNT_DOWN_TIME = 30
    
    // MARK: -Output
    public let registerEnabled: Driver<Bool>
    public let getVerificatioinEnabled: Driver<Bool>
    public let getVerificationLoading: Driver<Bool>
    public let registerLoading: Driver<Bool>
    
    public let countDownEnabled: Variable<(String, Bool)> = Variable(("获取验证码", false))
    public let secureTextStatus: Variable<(Bool, String)> = Variable((true, "hide_password"))
    public let getVerificationPostResult: Variable<PostResult> = Variable<PostResult>(.empty)
    public let registerPostResult: Variable<PostResult> = Variable<PostResult>(.empty)
    
    
    public init(
        input: (
        phone:   Driver<String>,
        password:  Driver<String>,
        verification:  Driver<String>,
        secureTextTap: Driver<Void>,
        getVerificationTap: Driver<Void>,
        registerTap: Driver<Void>)
        ) {
        
        let validPhone = input.phone.flatMapLatest{ $0.isValidPhone().asDriver(onErrorJustReturn: false)
        }
        
        let validPassword = input.password.flatMapLatest{$0.isValidPassword().asDriver(onErrorJustReturn: false)
        }
        
        getVerificatioinEnabled = validPhone
        
        registerEnabled = Driver.combineLatest(validPhone, input.verification, verification.asDriver(), validPassword) {
            $0 && $1 == $2 && $3
            }
            .distinctUntilChanged()
        
        getVerificationLoading = self.getVerificationPostResult
            .asDriver()
            .map{ postResult in
                switch postResult {
                case .loading:
                    return true
                default:
                    return false
                }
        }
        
        registerLoading = self.registerPostResult
            .asDriver()
            .map{ postResult in
                switch postResult {
                case .loading:
                    return true
                default:
                    return false
                }
        }
        
        input.secureTextTap.drive(onNext: { _ in
            if self.secureTextStatus.value.0 {
                self.secureTextStatus.value = (false, "not_hide_password")
            } else {
                self.secureTextStatus.value = (true, "hide_password")
            }
        }).disposed(by: disposeBag)
        
        // 获取验证码
        input.getVerificationTap
            .withLatestFrom(input.phone)
            .do(onNext:{ _ in
                self.getVerificationPostResult.value = .loading
            })
            .delay(CLICK_TIME_INTERVAL)
            .drive(onNext: { phone in
                ModelManager.getCodeNotVerify(phone: phone)
                .subscribe(onSuccess: { response in
                    self.getVerificationPostResult.value = .ok(message: "获取成功.")
                    self.verification.value = response
                    // 成功获取验证码后，启动倒计时30秒
                    Observable<Int>
                        .timer(0, period: 1, scheduler: MainScheduler.instance)
                        .take(self.COUNT_DOWN_TIME + 1)
                        .map{self.COUNT_DOWN_TIME - $0}
                        .map{String($0)}
                        .subscribe(onNext:{ [weak self] value in
                            self?.countDownEnabled.value = (value, false)
                            },onCompleted:{ [weak self] in
                                self?.countDownEnabled.value = ("获取验证码", true)
                        })
                        .disposed(by: self.disposeBag)
                }, onError: { error in
                    switch(error) {
                    case ResponseError.UnexpectedResult(let reason):
                        self.getVerificationPostResult.value = .fail(message: reason)
                        break
                    default:
                        self.getVerificationPostResult.value = .fail(message: NETWORK_FAIL)
                        break;
                    }
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        
        let phoneAndVerificationAndPassword = Driver.combineLatest(input.phone, input.verification, input.password) { (phone: $0, verification: $1, password: $2)}
        
        // 注册
        input.registerTap
            .withLatestFrom(phoneAndVerificationAndPassword)
            .do(onNext: { _ in
                self.registerPostResult.value = .loading
            })
            .delay(CLICK_TIME_INTERVAL)
            .drive(onNext: { pair in
                ModelManager.register(name: pair.phone, password: pair.password).subscribe(onSuccess: { response in
                    self.registerPostResult.value = .ok(message: "注册成功.")
                    ModelManager.shared.storeLoginInfo(name: pair.phone, password: pair.password, account: response)
                }, onError: { error in
                    switch(error) {
                    case ResponseError.UnexpectedResult(let reason):
                        self.registerPostResult.value = .fail(message: reason)
                        break
                    default:
                        self.registerPostResult.value = .fail(message: NETWORK_FAIL)
                        break;
                    }
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
    }
}

