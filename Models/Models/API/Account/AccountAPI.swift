//
//  AccountAPI.swift
//  Models
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import Moya

enum AccountAPI {
    case login(name: String, password: String)              // 登录
    case register(name: String, password: String)           // 注册
    case getCodeNotVerify(phone: String)                    // 获取验证码：不验证
    case getCodeVerify(phone: String)                       // 获取验证码：验证
    case modifyPassword(name: String, password: String)     // 修改密码
}

extension AccountAPI: TargetType {
    // URL
    public var baseURL: URL {
        return URL(string:ModelManager.shared.url)!
    }
    
    // 协议指定了你API端点相对于它base URL的位置
    public var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .register:
            return "/user/register"
        case .getCodeNotVerify:
            return "/user/message/authenticate"
        case .getCodeVerify:
            return "/user/message/check"
        case .modifyPassword:
            return "/user/password/edit"
        }
    }
    
    // 请求的方法
    public var method: Moya.Method {
        return .post
    }
    
    // task 属性代表你如何发送/接受数据，并且允许你向它添加数据、文件和流到请求体中。
    public var task: Task {
        switch self {
        case .login(let name, let password):
            return .requestData(LoginRequest(name, password).serialize())
        case .register(let name, let password):
            return .requestData(RegisterRequest(name, password).serialize())
        case .getCodeVerify(let phone):
            return .requestData(GetCodeVerifyRequest(phone).serialize())
        case .getCodeNotVerify(let phone):
            return .requestData(GetCodeNotVerifyRequest(phone).serialize())
        case .modifyPassword(let name, let password):
            return .requestData(ModifyPasswordRequest(name, password).serialize())
        }
    }
    
    // Whether or not to perform Alamofire validation. Defaults to `false`.
    public var validate: Bool {
        return true
    }
    
    
    // 用来后续的测试或者为开发者提供离线数据支持
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    // headers 属性存储头部字段，它们将在请求中被发送。
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
