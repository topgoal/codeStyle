//
//  AppDelegate.swift
//  Smart
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 topgoal. All rights reserved.
//

import UIKit
import Models
import ViewModels
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, JPUSHRegisterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initApperance()
        initPush(launchOptions: launchOptions)
        initVC()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            NSLog("did Fail To Register For Remote Notifications With Error: \(error)")
        }
    }
}

// MARK: - 配置
extension AppDelegate {
    func initApperance() {
        UINavigationBar.appearance().tintColor = UIColor.gray
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.clear], for: UIControlState.highlighted)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "完成"
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarManageBehaviour = .byPosition
    }
    
    func initVC() {
        ModelManager.shared.appId = appId
        ModelManager.shared.url = userUrl
        
        if ViewModelManager.shared.isLogin() {
            self.initRootViewController(name: mainStoryBoard)
        } else {
            self.initRootViewController(name: accountStoryBoard)
        }
    }
    
    func initRootViewController(name: String) {
        let storyBoard = UIStoryboard(name: name, bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = storyBoard.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
    }
}

// MARK: - 推送
extension AppDelegate {
    func initPush(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        let entity = JPUSHRegisterEntity()
        entity.types = 1 << 0 | 1 << 1 | 1 << 2
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        JPUSHService.setup(withOption: launchOptions, appKey: "5770c460a6d71807c2a05b7f", channel: "App Store", apsForProduction: false, advertisingIdentifier: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage(notification:)), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
    }
    
    // MARK: JPUSHRegisterDelegate
    // iOS 10 Support
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    // iOS 10 Support
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 系统要求执行这个方法
        completionHandler()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    @objc func networkDidReceiveMessage(notification: Notification) {
        let userInfo = notification.userInfo
        if let extras = userInfo?["extras"] as? [String: String] {
            NSLog("extras: \(extras)")
        }
        
        // 将自定义消息的内容转换成本地推送
        if let con = userInfo?["content"] as? String {
            if #available(iOS 10.0, *) {
                let content = UNMutableNotificationContent()
                content.body = con
                content.categoryIdentifier = "com.topgoal.smart"
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
                let request = UNNotificationRequest(identifier: "com.topgoal.smart",
                                                    content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } else {
                let notification = UILocalNotification()
                notification.alertBody = con
                notification.fireDate = NSDate(timeIntervalSinceNow: 0.01) as Date
                notification.repeatInterval = NSCalendar.Unit.second
                UIApplication.shared.cancelAllLocalNotifications()
                UIApplication.shared.scheduledLocalNotifications = [notification]
            }
        }
    }
}
