//
//  NibLoadable.swift
//  Smart
//
//  Created by 张光富 on 2018/5/26.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import UIKit

protocol NibLoadable {

}

extension NibLoadable where Self: UIView {
    static func loadNib(_ nibNmae: String? = nil) -> Self {
        return Bundle.main.loadNibNamed(nibNmae ?? "\(self)", owner: nil, options: nil)?.first as! Self
    }
}
