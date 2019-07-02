//
//  UIViewController+Extension.swift
//  Smart
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import MBProgressHUD
import RxSwift
import RxCocoa

extension UIViewController {
    func toast(_ message: String?) {
        guard message != nil else {
            return
        }
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.mode = MBProgressHUDMode.customView
        hud.isUserInteractionEnabled = false
        hud.customView = UIImageView(image: UIImage(named: "warn"))
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.bezelView.color = UIColor.black
        hud.label.textColor = UIColor.white
        hud.offset.y = -50
        hud.label.font = UIFont(name: "PingFangHK", size: 13)
        hud.hide(animated: true, afterDelay: 1.5)
    }
    
    func show(_ message: String = "加载中...") {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.margin = 20
        hud.label.font = UIFont(name: "PingFangHK", size: 13)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.bezelView.color = UIColor.black
        hud.bezelView.layoutMargins.bottom = 100
        hud.contentColor = UIColor.white
        hud.offset.y = -50
        hud.isUserInteractionEnabled = false
    }
    
    func hide() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

extension MBProgressHUD {
    class func createHUD(view: UIView) -> MBProgressHUD{
        let hud = MBProgressHUD.init()
        hud.label.text = "加载中..."
        hud.margin = 20
        hud.label.font = UIFont(name: "PingFangHK", size: 13)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.bezelView.color = UIColor.black
        hud.bezelView.layoutMargins.bottom = 100
        hud.contentColor = UIColor.white
        hud.offset.y = -50
        hud.isUserInteractionEnabled = false
        view.addSubview(hud)

        return hud
    }
}

extension Reactive where Base: MBProgressHUD {
    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { hud, active in
            if active {
                hud.show(animated: true)
            } else {
                hud.hide(animated: true)
            }
        }
    }
}
