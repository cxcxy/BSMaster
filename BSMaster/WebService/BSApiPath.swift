//
//  BSApiPath.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation

var BaseUrl = "http://192.168.108.141/coinmart/public/index.php/api/" //内网开发


var DES_KEY = "my.oschina.net/penngo?#@"
var DES_IV  = "01234567"

//let BaseUrl = "" //外网开发

let urlItunes = "https://itunes.apple.com/cn/app/jian-jiao-she-ji/id1110300308?mt=8" // Appstore 链接



/****************************API_URL接口**********************************/
public struct API {
    //MARK:  接口加密规则： 统一调用 此 API， 然后在参数里面 指定应该调用的地址
    static let URL_BaseURL          = "Base/code"

    //MARK: 登录注册相关接口
    static let URL_Login            = "Login/login"
    //TODO: 注册接口
    static let URL_Register         = "Login/register"
    //TODO: 第一次， 验证短信验证码是否正确
    static let URL_RegisterFister   = "Login/first_step"
    
    //TODO: 忘记登录密码
    static let URL_ForgetPass       = "Login/forgot_pass"
    //TODO: 修改登录密码
    static let URL_ChangePass       = "Login/changePwd"
    //TODO: 修改密码第一步， 判断原来密码是否正确的接口
    static let URL_FirstPass         = "Server/pass_first"
    
    //TODO: 设置支付密码
    static let URL_SetPayPass       = "Server/pay_password"
    //TODO: 忘记支付密码
    static let URL_ForgetPayPass    = "Server/forgot_paypass"
    //TODO: 实名认证
    static let URL_Authentication    = "Server/authentication"
    //TODO: 发送短信
    static let URL_PostCode         = "Login/verification_code"
    //MARK: 发布出售相关接口
    static let URL_ReleaseAd         = "Trade/release"
    //TODO:  交易列表
    static let URL_BuyList           = "Trade/trade_list"
    //TODO:  // 交易详情
    static let URL_TransactInfo      = "Trade/trade_info"
    //MARK: 手机区号相关接口
    static let URL_MobileType        = "Other/mobile"
    //MARK: 国家币种接口
    static let URL_Country           = "Other/country"
    
    //MARK: 关于我的，  --购买详情
     //TODO:  我购买的
    static let URL_Purchase          = "Server/purchase"
    //TODO:  购买详情
    static let URL_PurchaseDetails   = "Server/purchase_details"
    //TODO: 交易状态更换
    static let URL_PayType          = "Server/forgot_paypass"
    //TODO: 我的广告
    static let URL_MyAD             = "server/products"
    //TODO: 生成订单
    static let URL_CreateOrder             = "Trade/add_order"
}

