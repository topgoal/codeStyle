//
//  AccountImplementation.swift
//  Models
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public extension ModelManager {
    
    /// 登录
    /// - Parameters:
    ///   - name:        用户名.
    ///   - password:    密码.
    /// - Returns:       账号信息.
    static func login(name: String, password: String)  -> Single<Account> {
        return  sharedAPI.rx
            .request(MultiTarget(AccountAPI.login(name: name, password: password)))
            .asObservable()
            .mapModel(Account.self)
            .map{ account -> Account in
                ModelManager.shared.storeLoginInfo(name: name, password: password, account: account)
                return account
        }
    }

    /// 注册
    /// - Parameters:
    ///   - name:        用户名.
    ///   - password:    密码.
    /// - Returns:       账号信息.
    static func register(name: String, password: String)  -> Single<Account> {
        return  sharedAPI.rx
            .request(MultiTarget(AccountAPI.register(name: name, password: password)))
            .asObservable()
            .mapModel(Account.self)
            .map{ account -> Account in
                ModelManager.shared.storeLoginInfo(name: name, password: password, account: account)
                return account
        }
    }
        
    /// 获取验证码：不验证用户是否已经注册.
    /// - Parameters:
    ///   - phone:    电话号码.
    /// - Returns:    验证码.
    static func getCodeNotVerify(phone: String)  -> Single<String> {
        return  sharedAPI.rx
            .request(MultiTarget(AccountAPI.getCodeNotVerify(phone: phone)))
            .asObservable()
            .mapModel(Verification.self)
            .map{$0.code}
        
    }
    
    /// 获取验证码：验证用户是否已经注册.
    /// - Parameters:
    ///   - phone:    电话号码.
    /// - Returns:    验证码.
    static func getCodeVerify(phone: String)  -> Single<String> {
        return  sharedAPI.rx
            .request(MultiTarget(AccountAPI.getCodeVerify(phone: phone)))
            .asObservable()
            .mapModel(Verification.self)
            .map{$0.code}
    }
    
    /// 修改密码
    /// - Parameters:
    ///   - name:        用户名.
    ///   - password:    密码.
    /// - Returns:       账号信息.
    static func modifyPassword(name: String, password: String)  -> Single<Account> {
        return  sharedAPI.rx
            .request(MultiTarget(AccountAPI.modifyPassword(name: name, password: password)))
            .asObservable()
            .mapModel(Account.self)
            .map{ account -> Account in
                ModelManager.shared.storeLoginInfo(name: name, password: password, account: account)
                return account
        }
    }
}


