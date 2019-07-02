//
//  ModelManagerConstant.swift
//  Models
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Moya
import Foundation

let endpointClosure = { (target: MultiTarget) -> Endpoint in
    
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    // clientId
    // timestamp
    // client-sign
    var dict: Dictionary<String, String> = [:]
    dict["X-Top-Application-Id"] = ModelManager.shared.appId ?? ""
    dict["token"] = ModelManager.shared.token ?? ""
    
    return defaultEndpoint.adding(newHTTPHeaderFields: dict)
}

let sharedAPI = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure ,plugins: [NetworkLoggerPlugin(verbose: true)])

let cameraEndpointClosure = { (target: MultiTarget) -> Endpoint in
    
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    // clientId
    // timestamp
    // client-sign
    var dict: Dictionary<String, String> = [:]
    
    return defaultEndpoint.adding(newHTTPHeaderFields: dict)
}

let cameraSharedAPI = MoyaProvider<MultiTarget>(endpointClosure: cameraEndpointClosure ,plugins: [NetworkLoggerPlugin(verbose: true)])

