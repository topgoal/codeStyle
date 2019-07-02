//
//  Push+Extension.swift
//  Smart
//
//  Created by 张光富 on 2018/7/3.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension JPUSHService {
    // 设备别名
    static func setAlias(alias: String) {
        JPUSHService.setAlias(alias, completion: { (iResCode, iAlias, seq) in
            NSLog("设备别名结果：", "\(iResCode)" + (iAlias ?? "别名为空"))
        }, seq: 1)
    }
}
