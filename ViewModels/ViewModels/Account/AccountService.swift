//
//  AccountService.swift
//  ViewModels
//
//  Created by apple on 2018/5/14.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import RxSwift

extension String {
    // 电话号码
    
    func isValidPhone() -> Single<Bool> {
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         * 联通：130,131,132,152,155,156,185,186
         * 电信：133,1349,153,180,189,181(增加)
         */
        let MOBIL = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        /**
         * 中国移动：China Mobile
         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
         */
        let CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
        /**
         * 中国联通：China Unicom
         * 130,131,132,152,155,156,185,186
         */
        let CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$";
        /**
         * 中国电信：China Telecom
         * 133,1349,153,180,189,181(增加)
         */
        let CT = "^1((33|53|8[019])[0-9]|349)\\d{7}$";
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", MOBIL)
        let regexCM = NSPredicate(format: "SELF MATCHES %@", CM)
        let regexCU = NSPredicate(format: "SELF MATCHES %@", CU)
        let regexCT = NSPredicate(format: "SELF MATCHES %@", CT)
        if regexMobile.evaluate(with: self)||regexCM.evaluate(with: self)||regexCU.evaluate(with: self)||regexCT.evaluate(with: self) {
            return Single.just(true)
        } else {
            return Single.just(false)
        }
    }
    
    /*  密码
     *  1、长度 >= 6
     */
    func isValidPassword() -> Single<Bool> {
        let minLength = "^.{6,}$"
        let regexMinLength = NSPredicate(format: "SELF MATCHES %@", minLength)
        if regexMinLength.evaluate(with: self) {
            return Single.just(true)
        } else {
            return Single.just(false)
        }
    }
    
    /*  验证码
     *  1、长度 == 4
     *  2、均为数字
     */
    func isValidVerification() -> Single<Bool> {
        let minLength = "^\\d{4}$"
        let regexMinLength = NSPredicate(format: "SELF MATCHES %@", minLength)
        if regexMinLength.evaluate(with: self) {
            return Single.just(true)
        } else {
            return Single.just(false)
        }
    }
}

