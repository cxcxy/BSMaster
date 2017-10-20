//
//  BSUserManager.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/20.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

import Foundation

//TODO
struct BSUserManager {

    static let BSDeviceToken       = "BSDeviceToken"

    static var deviceToken:String {
        get{
            return (MGDefault.object(forKey: BSDeviceToken) as? String) ?? ""
        }
        set{
            MGDefault.set(newValue, forKey:BSDeviceToken)
            MGDefault.synchronize()
        }
    }

  
    
//    static func saveUserInfo(_ model:WOWUserModel?){
    
//        MGDefault.set(model?.user_nick, forKey:WOWUserName)
//        MGDefault.set(model?.user_sex, forKey:WOWUserSex)
//        MGDefault.set(model?.user_desc, forKey:WOWUserDes)
//        MGDefault.set(model?.user_headimage, forKey:WOWUserHeadImage)
//        MGDefault.set(model?.user_constellation, forKey:WOWUserConstellation)
//        MGDefault.set(model?.user_ageRange, forKey:WOWUserAgeRange)
//        MGDefault.set(model?.user_carCount, forKey:WOWUserCarCount)
//        MGDefault.set(model?.user_industry, forKey:WOWUserIndustry)
//        MGDefault.set(model?.user_id?.toString, forKey:WOWUserID)
//        MGDefault.set(model?.user_mobile, forKey:WOWUserMobile)
//        MGDefault.set(model?.bindWechat, forKey: WOWUserWechat)
//        MGDefault.set(model?.user_dateOfBirth, forKey: WOWUserBirth)
//
//        MGDefault.synchronize()
//    }
    
//    static func cleanUserInfo(){
//
//        MGDefault.set(nil, forKey:WOWUserName)
//        MGDefault.set(nil, forKey:WOWUserSex)
//        MGDefault.set(nil, forKey:WOWUserDes)
//        MGDefault.set(nil, forKey:WOWUserHeadImage)
//        MGDefault.set(nil, forKey:WOWUserConstellation)
//        MGDefault.set(nil, forKey:WOWUserAgeRange)
//        MGDefault.set(nil, forKey:WOWUserCarCount)
//        MGDefault.set(nil, forKey:WOWUserIndustry)
//        MGDefault.set("", forKey:WOWUserPhotoData)
//        MGDefault.set(nil, forKey: WOWSessionToken)
//        MGDefault.set(0, forKey: WOWUserMsgCount)
//        MGDefault.set(0, forKey: WOWSystemMsgCount)
//        MGDefault.set(nil, forKey:WOWUserID)
//        MGDefault.set(nil, forKey:WOWUserMobile)
//        MGDefault.set(false, forKey: WOWUserWechat)
//        MGDefault.set(nil, forKey: WOWUserBirth)
//
//        MGDefault.synchronize()
//    }
    /**
     退出登录
     清空用户的各个信息
     */
    static func exitLogin(){
//        cleanUserInfo()
    }
    
    
}

