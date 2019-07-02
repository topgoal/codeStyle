//
//  Defaults+Extension.swift
//  Models
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import SwiftyUserDefaults


public extension DefaultsKeys {
    static let model_name = DefaultsKey<String?>("model_name")
    static let model_password = DefaultsKey<String?>("model_password")
    static let model_token = DefaultsKey<String?>("model_token")
    static let model_pid = DefaultsKey<String?>("model_pid")
    static let model_expired = DefaultsKey<Double?>("model_expired")
}
