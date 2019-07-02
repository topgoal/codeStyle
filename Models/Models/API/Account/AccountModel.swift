//
//  AccountModel.swift
//  Models
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation

// 模型
/// 账号
public struct Account : Codable {
    public let token: String
    public let pid: String
    public let expired: Double
}

/// 获取验证码
public struct Verification : Codable {
    public let code: String
}


////////////////////////////////////////////////////////////////////////////////////////////////////


// 网络请求
/// 登录
/// 请求:
struct LoginRequest : Serializable {
    var loginName: String
    var loginPassword: String
    
    init(_ name:String, _ password:String) {
        self.loginName = name
        self.loginPassword = password
    }
}
/// 返回:
/// Account


/// 注册
/// 请求:
struct RegisterRequest : Serializable {
    var loginName: String
    var loginPassword: String
    
    init(_ name:String, _ password:String) {
        self.loginName = name
        self.loginPassword = password
    }
}
/// 返回:
/// Account


/// 获取验证码：不验证用户
/// 请求:
struct GetCodeNotVerifyRequest : Serializable {
    var recNum: String
    
    init(_ recNum:String) {
        self.recNum = recNum
    }
}
/// 返回:
/// Verification


/// 获取验证码：验证用户
/// 请求:
struct GetCodeVerifyRequest : Serializable {
    var recNum: String
    
    init(_ recNum:String) {
        self.recNum = recNum
    }
}
/// 返回:
/// Verification


/// 修改密码
/// 请求:
struct ModifyPasswordRequest: Serializable {
    var loginName: String
    var loginPassword: String
    
    init(_ name:String, _ password:String) {
        self.loginName = name
        self.loginPassword = password
    }
}
/// 返回:
/// Account

