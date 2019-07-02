//
//  RegisterVC.swift
//  Account
//
//  Created by apple on 2018/1/17.
//  Copyright © 2018年 张光富. All rights reserved.
//

import UIKit
import MBProgressHUD
import RxCocoa
import RxSwift
import ViewModels

class RegisterVC: BaseViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var verificationTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var secureTextButton: UIButton!
    @IBOutlet weak var getVerificationButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    func initView() {
        // 点击注册按钮，隐藏软键盘
        registerButton.rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            }).disposed(by: disposeBag)
    }
    
    func initViewModel() {
        // 初始化视图模型
        let viewModel = RegisterViewModel(input: (
            phone: phoneTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            verification: verificationTextField.rx.text.orEmpty.asDriver(),
            secureTextTap: secureTextButton.rx.tap.asDriver(),
            getVerificationTap: getVerificationButton.rx.tap.asDriver(),
            registerTap: registerButton.rx.tap.asDriver()))
        
        // 是否可获取验证码
        viewModel.getVerificatioinEnabled
            .drive(onNext: { [weak self] enable in
                self?.getVerificationButton.isEnabled = enable
                self?.getVerificationButton.alpha = enable ? 1.0 : 0.5
            }).disposed(by: disposeBag)
        
        // 是否可登陆
        viewModel.registerEnabled
            .drive(onNext: { [weak self] enable in
                self?.registerButton.isEnabled = enable
                self?.registerButton.alpha = enable ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        // 安全文本状态
        viewModel.secureTextStatus
            .asDriver()
            .drive(onNext: { [weak self] (hide, image) in
                self?.passwordTextField.isSecureTextEntry = hide
                self?.secureTextButton.setImage(UIImage(named: image), for: .normal)
            }).disposed(by: disposeBag)
        
        // 获取验证码按钮文本
        viewModel.countDownEnabled
            .asDriver()
            .drive(onNext:{ [weak self] (text, enable) in
                self?.getVerificationButton.setTitle(text, for: .normal)
                self?.getVerificationButton.isEnabled = enable
                self?.getVerificationButton.alpha = enable ? 1.0 : 0.5
            }).disposed(by: disposeBag)
        
        // 获取验证码状态
        let getVerificationProgress = MBProgressHUD.createHUD(view: self.view)
        viewModel.getVerificationLoading
            .drive(getVerificationProgress.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // 获取验证码请求结果
        viewModel.getVerificationPostResult.asDriver().drive(onNext: { [weak self] postResult in
            switch postResult {
            case .fail(let message):
                self?.toast(message)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        // 获取验证码请求结果
        viewModel.registerPostResult.asDriver().drive(onNext: { [weak self] postResult in
            switch postResult {
            case .fail(let message):
                self?.toast(message)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        // 注册状态
        let registerProgress = MBProgressHUD.createHUD(view: self.view)
        viewModel.registerLoading
            .drive(registerProgress.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // 注册请求结果
        viewModel.registerPostResult.asDriver().drive(onNext: { [weak self] postResult in
            switch postResult {
            case .ok(let message):
                self?.toast(message)
                JPUSHService.setAlias(alias: self?.phoneTextField.text ?? "")
                let storyBoard = UIStoryboard(name: mainStoryBoard, bundle: nil)
                self?.view.window?.rootViewController = storyBoard.instantiateInitialViewController()
            case .fail(let message):
                self?.toast(message)
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}
