//
//  Refreshable.swift
//  ViewModels
//
//  Created by apple on 2018/5/27.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import Foundation
import MJRefresh
import RxSwift
import RxCocoa

public enum RefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case endFooterRefresh
    case endAllRefresh
    // 这个枚举由于在我项目中经常用到，所以我定一个关联值的枚举。
    // 项目中需要：
    //  - 数据为空的时候隐藏 `mj_footer`，否则显示；
    //  - 然后判断没有更多数据就调用 `endRefreshingWithNoMoreData()`
    //    否则 `endRefreshing()`
    case footerStatus(isHidden: Bool, isNoMoreData: Bool)
}

public protocol Refreshable {
    var refreshStatus: BehaviorSubject<RefreshStatus> { get }
}

extension Refreshable {
    
    public func refreshStatusBind(to scrollView: UIScrollView, timeKey: String, _ header: (() -> Void)? = nil, _ footer: (() -> Void)? = nil) -> Disposable {
        
        if header != nil {
            scrollView.mj_header = MJRefreshNormalHeader {
                // 处理头部方法时结束尾部刷新。
                scrollView.mj_footer?.endRefreshing()
                header?()
            }
            scrollView.mj_header.lastUpdatedTimeKey = timeKey
        }
        if footer != nil {
            scrollView.mj_footer = MJRefreshAutoNormalFooter {
                // 处理尾部方法时结束头部刷新。
                scrollView.mj_header?.endRefreshing()
                footer?()
            }
        }
        
        return refreshStatus.subscribe(onNext: { (status) in
            switch status {
            case .none:
                // 未发生任何状态事件时隐藏尾部。
                scrollView.mj_footer?.isHidden = true
            case .beingHeaderRefresh:
                scrollView.mj_header?.beginRefreshing()
            case .endHeaderRefresh:
                scrollView.mj_header?.endRefreshing()
            case .endFooterRefresh:
                scrollView.mj_footer?.endRefreshing()
            case .endAllRefresh:
                // 结束全部拉刷新
                scrollView.mj_header?.endRefreshing()
                scrollView.mj_footer?.endRefreshing()
            case .footerStatus(let isHidden, let isNone):
                // 根据关联值确定 footer 的状态。
                scrollView.mj_footer?.isHidden = isHidden
                // 处理尾部状态时，如果之前正在刷新头部，则结束刷新，
                // 至此，我们无需写判断结束头部刷新的代码，在这里自动处理。
                scrollView.mj_header?.endRefreshing()
                if isNone {
                    scrollView.mj_footer?.endRefreshingWithNoMoreData()
                }else {
                    scrollView.mj_footer?.endRefreshing()
                }
            }
        })
    }
}

