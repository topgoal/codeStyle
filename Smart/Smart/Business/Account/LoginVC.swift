//
//  LoginVC.swift
//  Account
//
//  Created by apple on 2018/1/17.
//  Copyright © 2018年 张光富. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ViewModels
import MBProgressHUD

class LoginVC: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var secureTextButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    func initView() {
        logoImageView.image = UIImage.init(named: "slogo")
        
        // 点击登录按钮，隐藏软键盘
        loginButton.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    
    func initViewModel() {
        // 初始化视图模型
        let viewModel = LoginViewModel(input: (
            phone: phoneTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            secureTextTap: secureTextButton.rx.tap.asDriver(),
            loginTap: loginButton.rx.tap.asDriver()
        ))
        
        // 是否可登陆
        viewModel.loginEnabled
            .drive(onNext: { [weak self] enable in
                self?.loginButton.isEnabled = enable
                self?.loginButton.alpha = enable ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        // 安全文本状态
        viewModel.secureTextStatus
            .asDriver()
            .drive(onNext: { [weak self] (hide, image) in
                self?.passwordTextField.isSecureTextEntry = hide
                self?.secureTextButton.setImage(UIImage(named: image), for: .normal)
            }).disposed(by: disposeBag)
        
        // 登录状态
        let hud = MBProgressHUD.createHUD(view: self.view)
        viewModel.loading
            .drive(hud.rx.isAnimating)
            .disposed(by: disposeBag)
        
        // 请求结果
        viewModel.postResult.asDriver().drive(onNext: { [weak self] postResult in
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
