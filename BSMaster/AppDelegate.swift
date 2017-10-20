//
//  AppDelegate.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        self.window?.makeKeyAndVisible()

        BSShareManager.config_init() // 配置友盟信息
        BSRCloudManager.config_init() // 配置融云信息
        IQKeyboardManager.sharedManager().enable = true
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){

        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        BSUserManager.deviceToken = deviceTokenString
        
        
    }
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
     
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
     
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
      
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = UMSocialManager.default().handleOpen(url, options: options)
        if !result {
            // 其他如支付等SDK的回调
            return false
        }
        print("分享成功")
        return true
    }

}

