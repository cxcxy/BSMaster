//
//  BSRCloudManager.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/18.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation

public class BSRCloudManager {
    
    public static func config_init() {
        RCIM.shared().initWithAppKey(BSShareID.RongCloud.appID)
        RCIM.shared().connect(withToken: BSShareID.RongCloud.testToken, success: { (userID) in
            print("登陆成功。当前登录的用户ID：\(String(describing: userID))")
        }, error: { (status) in
            print("登陆的错误码为: \(status)")
        }) {
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            print("token 错误")
        }
    }
}
