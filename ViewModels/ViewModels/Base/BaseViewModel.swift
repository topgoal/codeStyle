//
//  BaseViewModel.swift
//  ViewModels
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

let NETWORK_FAIL = "似乎已断开与互联网的连接!"
let CLICK_TIME_INTERVAL = RxTimeInterval(1)                    // 点击延迟时间

// 用户发出请求的结果
// 1、验证用户的手机号码，不正确，返回 .fail("请输入正确的手机号码.")
// 2、校验用户的密码，不正确，返回 .fail("请输入正确的密码")
// 3、登录，不成功，返回 .fail(message)
// 4、登录成功，返回 .ok
// 5、默认状态为 .empty
// 6、发起网络请求为 .loading
public enum PostResult {
    case empty
    case loading
    case ok(message: String?)        // 请求成功：校验和网络均成功
    case fail(message: String)      // 请求失败：校验或网络失败
}

/// 视图模型基类
public class BaseViewModel {
    let disposeBag = DisposeBag()
    public let postResult: Variable<PostResult> = Variable<PostResult>(.empty)
    public var placeholderIsHidden: Driver<Bool>?
    
    // MARK: -Output
    public let loading: Driver<Bool>
    
    init() {
        loading = self.postResult.asDriver().map{ value in
            switch value {
            case .loading:
                return true
            default:
                return false
            }
        }
    }
}

























