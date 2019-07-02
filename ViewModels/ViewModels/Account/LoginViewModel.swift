//
//  LoginViewModel.swift
//  ViewModels
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Models

public class LoginViewModel: BaseViewModel {
    
    // MARK: -Output
    public let loginEnabled: Driver<Bool>
    public let secureTextStatus: Variable<(Bool, String)> = Variable((true, "hide_password"))
    
    public init(
        input: (
        phone:   Driver<String>,
        password:  Driver<String>,
        secureTextTap: Driver<Void>,
        loginTap: Driver<Void>)
        ) {
        
        let validPhone = input.phone.flatMapLatest{ $0.isValidPhone().asDriver(onErrorJustReturn: false)
        }
        
        let validPassword = input.password.flatMapLatest{$0.isValidPassword().asDriver(onErrorJustReturn: false)
        }

        loginEnabled = Driver.combineLatest(validPhone, validPassword) {
            phone, password in
            phone && password
            }
            .distinctUntilChanged()
        
        super.init()
        
        input.secureTextTap.drive(onNext: { _ in
            if self.secureTextStatus.value.0 {
                self.secureTextStatus.value = (false, "not_hide_password")
            } else {
                self.secureTextStatus.value = (true, "hide_password")
            }
        }).disposed(by: disposeBag)
        
        let phoneAndPassword = Driver.combineLatest(input.phone, input.password) { (phone: $0, password: $1)}
        
        input.loginTap
            .withLatestFrom(phoneAndPassword)
            .do(onNext: { _ in
                self.postResult.value = .loading
            })
            .delay(CLICK_TIME_INTERVAL)
            .drive(onNext: { pair in
                ModelManager.login(name: pair.phone, password: pair.password).subscribe(onSuccess: { response in
                    self.postResult.value = .ok(message: "登录成功.")
                    // 保存登录信息
                    input.phone.drive(onNext:{ phone in
                        ModelManager.shared.storeLoginInfo(name: phone, password: pair.password, account: response)
                    }).disposed(by: self.disposeBag)
                }, onError: { error in
                    switch(error) {
                    case ResponseError.UnexpectedResult(let reason):
                        self.postResult.value = .fail(message: reason)
                        break
                    default:
                        self.postResult.value = .fail(message: NETWORK_FAIL)
                        break;
                    }
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
    }
}


