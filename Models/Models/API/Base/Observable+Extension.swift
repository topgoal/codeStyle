//
//  Single+Extension.swift
//  Models
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import RxSwift
import Moya

/*
    1、返回的JSON数据为结构体时，键有时返回(可能值为null)，有时不返回，定义为Optional形式。
    2、日期处理。
    3、枚举处理。
    4、数据类型不一致处理。
 */

public enum ResponseError : Swift.Error {
    // 服务器没有响应
    case ServerNoResponse
    // 网络请求发生错误
    case RequestFailed
    // 解析失败
    case ParseJSONError
    // token认证失败
    case AuthenticationFail
    // 服务器返回了一个错误代码
    case UnexpectedResult( _: String)
}

enum RequestStatus: Int {
    case requestSuccess =  1
    case requestError
}

let RESPONSE_RESULT = "result"
let RESPONSE_REASON = "reason"
let RESPONSE_DATA = "data"

extension Observable {
    func mapModel<T: Decodable>(_ type: T.Type) -> Single<T> {
        return map{ response -> T in
            // 得到response
            guard let response = response as? Moya.Response else {
                NSLog("服务器没有响应")
                throw ResponseError.UnexpectedResult("服务器没有响应")
            }
            
            // 转换为字典
            guard let dic = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]  else {
                NSLog("服务器返回的数据转换为字典出错")
                throw ResponseError.UnexpectedResult("服务器返回的数据转换为字典出错")
            }
            
            // 判断返回的结果
            guard let code = dic[RESPONSE_RESULT] as? Int, code == RequestStatus.requestSuccess.rawValue else {
                let reason = dic[RESPONSE_REASON] as? String ?? "服务器返回的reason字段为空"
                throw ResponseError.UnexpectedResult(reason)
            }
            
            // 判断返回的数据是否为空
            guard let data = dic[RESPONSE_DATA] as? [String : Any] else {
                NSLog("服务器返回的data字段为空")
                throw ResponseError.UnexpectedResult("服务器返回的data字段为空")
            }
            
            // 对数据进行序列化
            guard let json = try? JSONSerialization.data(withJSONObject: data, options: []) else {
                NSLog("data转换为Json数据出错");
                throw ResponseError.UnexpectedResult("data转换为Json数据出错")
            }
            
            // 对象映射
            do {
                let decode = JSONDecoder()
                let object = try decode.decode(T.self, from: json)
                print(object)
                return object
            } catch {
                print(error)
                throw ResponseError.UnexpectedResult("JSON数据解析为对象出错")
                
            }
        }.asSingle()
    }
    
    func mapNilModel() -> Single<Bool> {
        return map { response in
            // 得到response
            guard let response = response as? Moya.Response else {
                NSLog("服务器没有响应")
                throw ResponseError.UnexpectedResult("服务器没有响应")
            }

            // 转换为字典
            guard let dic = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]  else {
                NSLog("服务器返回的数据转换为字典出错")
                throw ResponseError.UnexpectedResult("服务器返回的数据转换为字典出错")
            }

            // 判断返回的结果
            guard let code = dic[RESPONSE_RESULT] as? Int, code == RequestStatus.requestSuccess.rawValue else {
                let reason = dic[RESPONSE_REASON] as? String ?? "服务器返回的reason字段为空"
                throw ResponseError.UnexpectedResult(reason)
            }

            return true;
        }.asSingle()
    }

    func mapArray<T: Decodable>(_ type: T.Type) -> Single<[T]> {
        return map { response in
            // 得到response
            guard let response = response as? Moya.Response else {
                NSLog("服务器没有响应")
                throw ResponseError.UnexpectedResult("服务器没有响应")
            }

            // 转换为字典
            guard let dic = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]  else {
                NSLog("服务器返回的数据转换为字典出错")
                throw ResponseError.UnexpectedResult("服务器返回的数据转换为字典出错")
            }

            // 判断返回的结果
            guard let code = dic[RESPONSE_RESULT] as? Int, code == RequestStatus.requestSuccess.rawValue else {
                let reason = dic[RESPONSE_REASON] as? String ?? "服务器返回的reason字段为空"
                throw ResponseError.UnexpectedResult(reason)
            }

            if let _ = dic[RESPONSE_DATA] as? NSNull {
                NSLog("服务器返回的data字段NSNull")
                return []
            }
    
            // 判断返回的数据是否为空
            guard let data = dic[RESPONSE_DATA] else {
                NSLog("服务器返回的data字段为空")
                throw ResponseError.UnexpectedResult("服务器返回的data字段为空")
            }
            
            // 对数据进行序列化
            guard let json = try? JSONSerialization.data(withJSONObject: data, options: []) else {
                NSLog("data转换为Json数据出错");
                //throw ResponseError.UnexpectedResult("data转换为Json数据出错")
                return []
            }

            print(json)

            // 对象映射
            do {
                let decode = JSONDecoder()
                let object = try decode.decode([T].self, from: json)
                print(object)
                return object
            } catch {
                print(error)
                throw ResponseError.UnexpectedResult("JSON数据解析为对象出错")
                
            }
            
//            let decode = JSONDecoder()
//            let object = try? decode.decode([T].self, from: json)
//            if object != nil {
//                return object!
//            }else {
//                
//                throw ResponseError.UnexpectedResult("JSON数据解析为对象出错")
//            }

        }.asSingle()
    }
}


