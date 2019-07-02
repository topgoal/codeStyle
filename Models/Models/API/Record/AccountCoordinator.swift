//
//  LoginNavigator.swift
//  Smart
//
//  Created by apple on 2018/6/11.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import UIKit
import Models
import RxSwift
import ViewModels

class AccountCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    // Here we define a set of supported destinations using an enum,
    // and we can also use associated values to add support for passing
    // arguments from one viewcontroller to another.
    enum Destination {
        case loginCompleted             // 登录完成，进入主页面
        case register                   // 注册
        case verificationLogin          // 验证码登录
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = LoginViewModel
        let viewController = RepositoryListViewController.initFromStoryboard(name: "Main")
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
