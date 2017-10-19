//
//  BSMyBuyModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/19.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
import ObjectMapper
//MARK: 交易详情 模型
class BSMyBuyModel: NSObject,Mappable {
    
    var id                  :   Int?
    var type                :   String?
    var price               :   String?
    var payment             :   String?
    var currency_code       :   String?
    var min_num             :   Int?
    var max_num             :   Int?

    var create_time         :   String?
    var is_del              :   String?
    override init(){
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id                                  <- map["id"]
        price                               <- map["price"]
        currency_code                       <- map["currency_code"]
        min_num                             <- map["min_num"]
        max_num                             <- map["max_num"]
        payment                             <- map["payment"]
        type                                <- map["type"]
        create_time                         <- map["create_time"]
        is_del                              <- map["is_del"]
    }
    
}
