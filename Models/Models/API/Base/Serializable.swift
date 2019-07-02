//
//  Serializable.swift
//  Models
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation

protocol Serializable: Codable {
    func serialize() -> Data
}

extension Serializable {
    func serialize() -> Data {
        let encoder = JSONEncoder()
        let dic = ["data": self]
        guard let data = try? encoder.encode(dic) else {
            fatalError()
        }
        return data;
    }
    
    func getAccessTokenSerialize() -> Data {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else {
            fatalError()
        }
        return data;
    }
}

extension Array where Element: Serializable {
    func serialize() -> Data {
        let encoder = JSONEncoder()
        let dic = ["data": self]
        guard let data = try? encoder.encode(dic) else {
            fatalError()
        }
        return data;
    }
}
