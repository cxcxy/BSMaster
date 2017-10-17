//
//  BSLoginModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import ObjectMapper
public struct RegisterModel {
    var phone       :   String = ""// 手机号
    var verCode     :   String = ""// 验证码
    var passwWord   :   String = ""// 密码
    var mobile_type :   String = ""// 手机区号
}

class BSRegisterFirstModel: NSObject {
    var mobile_type     :String
    var mobile          :String
    var type            :String
    var vcode           :String

     init(mobile_type:String,mobile:String,type:String,vcode:String) {
        
        self.mobile_type = mobile_type
        self.mobile      = mobile
        self.type           =  type
        self.vcode      = vcode
    }

}


class BSMobileListModel:NSObject, Mappable {

    var data                    : [BSCountryModel]?
    var title : String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        data                    <- map["data"]
        title                   <- map["title"]
    }
}
class BSCountryModel:NSObject, Mappable {
    var id                      : Int?  // id
    var name                    : String? // 国家名称
    var country_code            : String? // 国家代号
    var currency_name           : String? // 货币名称
    var currency_code           : String? // 货币代号
    var shou                    : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id                      <- map["id"]
        name                    <- map["name"]
        country_code            <- map["country_code"]
        currency_name           <- map["currency_name"]
        currency_code           <- map["currency_code"]
        shou                    <- map["shou"]

    }
}
