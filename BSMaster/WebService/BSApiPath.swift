//
//  BSApiPath.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation

var BaseUrl = "http://192.168.108.141/coinmart_local/public/index.php/api/" //内网开发

//let BaseUrl = "" //外网开发

let urlItunes = "https://itunes.apple.com/cn/app/jian-jiao-she-ji/id1110300308?mt=8" // Appstore 链接



/****************************API_URL接口**********************************/
public struct API {
    //MARK: 登录注册相关接口
    static let URL_Login            = "Login/login"
    static let URL_Register         = "Login/register"
    static let URL_RegisterFister   = "Login/first_step"
    static let URL_ForgetPass       = "Login/forgot_pass"
    static let URL_ChangePass       = "Login/changePwd"
    
    //MARK: 发布出售相关接口
    static let URL_ReleaseAd         = "Trade/release"
    
    //MARK: 手机区号相关接口
    static let URL_MobileType        = "Other/mobile"
    //MARK: 国家币种接口
    static let URL_Country           = "Other/country"
    
}

