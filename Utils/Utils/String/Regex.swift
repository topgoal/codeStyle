//
//  Regex.swift
//  Utils
//
//  Created by apple on 2018/8/6.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation

extension String {
    /// 判断是否有效的移动电话
    /// - Parameters:
    /// - Returns: 是，返回true；不是，返回false.
    func isValidMobile() -> Bool {
        /**
         * Regex of exact mobile.
         * <p>china mobile: 134(0-8), 135, 136, 137, 138, 139, 147, 150, 151, 152, 157, 158, 159, 178, 182, 183, 184, 187, 188, 198</p>
         * <p>china unicom: 130, 131, 132, 145, 155, 156, 166, 171, 175, 176, 185, 186</p>
         * <p>china telecom: 133, 153, 173, 177, 180, 181, 189, 199</p>
         * <p>global star: 1349</p>
         * <p>virtual operator: 170</p>
         */
        let mobile = "^((13[0-9])|(15[^4])|(18[0-9])|(17[0-8])|(14[5-9])|(166)|(19[8,9])|)\\d{11}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@",mobile)
        if ((predicate.evaluate(with: self) == true)) {
            return true
        } else {
            return false
        }
    }
}
