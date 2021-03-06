//
//  BSPostModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import ObjectMapper
//MARK: UI 展示数据 style
class BSPostStyleModel: NSObject {
    var title:String        = ""            // 标题
    var content:String      = ""            // 内容
    var imgRight:Bool       =  false        // 是否显示右边 >图标
    var plactHold:String    = ""            // 占位字符串
    var coinType:String     = ""            // 占位字符串
    var inputType:BSPostInputType = .Locus  // 输入类型
    var isInput:Bool        = true          // 是否可以输入
    init(title:String, content:String,coinType:String = "",placHold:String,imgRight:Bool = false,inputType:BSPostInputType = .Locus,isInput:Bool = true) {
        self.title          = title
        self.content        = content
        self.plactHold      = placHold
        self.coinType       = coinType
        self.imgRight       = imgRight
        self.inputType      = inputType
        self.isInput        = isInput
        
    }
}
//MARK: 请求 发布接口 模型
class BSPostModel: NSObject,Mappable {

    var type:String              =  ""
    var coin_type:String            =  "1" //1比特币，2莱特币，3以太坊，4BACC积分，5贝壳币
    var member_id:String            =  ""
    var is_safe:String              =  "2"
    var country_id:String            = "44"
    var currency_code:String        =  "CNY"
    var premium_rate:String         =  ""
    var price:String                =  ""
    var min_price:String            =  ""
    var max_price:String?
    var min_num:String              =  ""
    var max_num:String              =  ""
    var payment:String              =  "1"
    var message:String              =  ""
    var payment_term:String?
    
    override init(){
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        type                <- map["type"]
        coin_type           <- map["coin_type"]
        member_id           <- map["member_id"]
        is_safe             <- map["is_safe"]
        country_id          <- map["country_id"]
        currency_code       <- map["currency_code"]
        premium_rate        <- map["premium_rate"]
        price               <- map["price"]
        min_price           <- map["min_price"]
        max_price           <- map["max_price"]
        min_num             <- map["min_num"]
        max_num             <- map["max_num"]
        payment             <- map["payment"]
        message             <- map["message"]
        payment_term        <- map["payment_term"]
    }

}
//MARK: 请求 搜索接口 模型
class BSSearchModel: NSObject,Mappable {
    
    var type                :String?
    var coin_type           :String?
    var country_id          :String?
    var page                :Int?//当前页
    var page_size           :Int?//显示条数
    var min_price           :String?
    var max_price           :String?
    var payment             :String?
    var currency_code       :String?
    var nickname            :String?

    override init(){
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        type                <- map["type"]
        coin_type           <- map["coin_type"]
        country_id          <- map["country_id"]
        page                 <- map["page"]
        page_size            <- map["page_size"]
        currency_code       <- map["currency_code"]
        min_price           <- map["min_price"]
        max_price           <- map["max_price"]
        payment             <- map["payment"]
        nickname             <- map["nickname"]

    }
    
}
//MARK: 请求 创建购买 ／ 出售 订单 模型
class BSCreateOrderModel: NSObject,Mappable {
    
    var member_id                   :String?//用户令牌
    var product_id                  :String?//广告id
    var price                       :String? //交易金额
    var coin_num                    :String?//交易币种数量

    
    override init(){
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        member_id                   <- map["member_id"]
        product_id                  <- map["product_id"]
        price                       <- map["price"]
        coin_num                    <- map["coin_num"]

    }
    
}
//MARK: 列表页模型
class BSPostListModel: NSObject,Mappable {
    
    var id                  :Int?
    var favicon             :String?
    var nickname            :String?
    var price               :String?
    var currency_code       :String?//货币
    var min_num             :Int?
    var max_num             :Int?
    var transaction_count   :Int?
    var favorable_rate      :Int?
    var trust_count         :Int?
    var payment             :String?


    override init(){
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id                                  <- map["id"]
        favicon                             <- map["favicon"]
        nickname                            <- map["nickname"]
        price                               <- map["price"]
        currency_code                       <- map["currency_code"]
        min_num                             <- map["min_num"]
        max_num                             <- map["max_num"]
        transaction_count                   <- map["transaction_count"]
        favorable_rate                      <- map["favorable_rate"]
        trust_count                         <- map["trust_count"]
        payment                             <- map["payment"]
        
    }
    
}
//MARK: 交易详情 模型
class BSTransactDetailModel: NSObject,Mappable {
    
    var product_id                  :Int?
    var member_id                   :Int?
    var favicon                      :String?
    var nickname                    :String?
    var price                       :String?
     var currency_code             :String?
    var min_num             :Int?
    var max_num             :Int?
    var transaction_count   :Int?
    var favorable_rate      :Int?
    var trust_count         :Int?
    var historical_transaction:Double?
    var payment             :String?
    var message             :String?
    var type                : String?
    override init(){
        
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        product_id                                  <- map["product_id"]
        member_id                             <- map["member_id"]
        favicon                            <- map["favicon"]
       nickname                            <- map["nickname"]
        price                               <- map["price"]
        currency_code                       <- map["currency_code"]
        min_num                             <- map["min_num"]
        max_num                             <- map["max_num"]
        transaction_count                   <- map["transaction_count"]
        favorable_rate                      <- map["favorable_rate"]
        trust_count                         <- map["trust_count"]
        historical_transaction              <- map["historical_transaction"]
        payment                             <- map["payment"]
        message                             <- map["message"]
        type                                <- map["type"]
    }
    
}
