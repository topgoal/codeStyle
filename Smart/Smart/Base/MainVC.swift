//
//  ViewController.swift
//  Account
//
//  Created by 张光富 on 2018/1/2.
//  Copyright © 2018年 张光富. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MBProgressHUD
import SwiftyUserDefaults

class MainVC: UITabBarController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
        initEvent()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func initView() {
        
    }
    
    func initViewModel() {
        
    }
    
    func initEvent() {
        
    }
}





























