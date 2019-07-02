//
//  UserDefaults.swift
//  ViewModels
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//
import Models
import Foundation
import SwiftyUserDefaults

public class ViewModelManager {
    
    public static let shared = ViewModelManager()

    public func isLogin() -> Bool {
        if Defaults[.view_model_name] != nil {
            return true
        } else {
            return false
        }
    }
    
    public func existLogin() {
        Defaults[.view_model_name] = nil
    }
    
    // 登录成功后保存，在token失效时，用户无需再次登录，直接用存储的信息获取token
    var token: String? {
        return Defaults[.view_model_token]
    }
    
    public var name: String? {
        return Defaults[.view_model_name]
    }
    
    var password: String? {
        return Defaults[.view_model_password]
    }
    
    public var userPid: String {
        return Defaults[.view_model_pid]!
    }
    
    func storeLoginInfo(name: String, password: String, account: Account) {
        Defaults[.view_model_name] = name
        Defaults[.view_model_password] = password
        Defaults[.view_model_token] = account.token
        Defaults[.view_model_pid] = account.pid
        Defaults[.view_model_expired] = account.expired
    }
}

