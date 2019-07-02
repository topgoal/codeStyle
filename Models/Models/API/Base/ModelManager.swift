//
//  ModelManager.swift
//  Models
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

public class ModelManager {
    public static var shared = ModelManager()
    
    public func storeLoginInfo(name: String, password: String, account: Account) {
        Defaults[.model_name] = name
        Defaults[.model_password] = password
        Defaults[.model_token] = account.token
        Defaults[.model_pid] = account.pid
        Defaults[.model_expired] = account.expired
    }
    
    // 初始化信息
    public var appId: String!
    public var url: String!
    
    var token: String? {
        return Defaults[.model_token]
    }
    
    var pid: String? {
        return Defaults[.model_pid]
    }
    
    var expired: Double? {
        return Defaults[.model_expired]
    }
    
    var name: String? {
        return Defaults[.model_name]
    }
    
    var password: String? {
        return Defaults[.model_password]
    }
    
}
