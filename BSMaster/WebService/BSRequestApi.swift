//
//  BSRequestApi.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
import Moya


public enum RequestApi{
    //MARK: 登录注册相关接口
    case api_Login(params: [String: Any])
    case api_register(params: [String: Any])
    case api_forgetPass(params: [String: Any])
    case api_changePass(params: [String: Any])
    case api_registerFister(params: [String: Any])
    case api_postCode(mobile:String)
    
    case api_setPayPass(params: [String: Any])
    case api_forgetPayPass(params: [String: Any])
    
    case api_FirstPass(old_pass:String,type:String,member_id:String)
    
    case api_authentication(idcard:String,name:String,member_id:String)
    //MARK: 发布出售相关接口
    case api_release(params: [String: Any])
    case api_buyList(params: [String: Any])
    case api_transactInfo( transactId:String)
    //TODO: 生成订单
    case api_CreateOrder(product_id:String,price:String,coin_num:String,member_id:String)
    //MARK: 手机区号相关接口
    case api_MobileType(lang:String)
    case api_Country(lang:String)
    case api_Purchase(type:String,member_id:String)
    case api_PurchaseDetails(id:String)
    case api_PayType(payment:String,id:String)
    case api_MyAD(is_del:String,member_id:String)
}
let provider = RxMoyaProvider<RequestApi>()
extension RequestApi:TargetType{

    public func headers() -> [String: String] {
        return [:]
    }
    
    public var task: Task {
         return .request
    }
    
    public var baseURL:URL{
        return URL(string: BaseUrl)!
    }
    
    public var path:String{
        switch self {
        case .api_Login:
            return API.URL_Login
        case .api_register:
            return API.URL_Register
        case .api_forgetPass:
            return API.URL_ForgetPass
        case .api_changePass:
            return API.URL_ChangePass
        case .api_registerFister:
            return API.URL_RegisterFister
        case .api_release:
            return API.URL_ReleaseAd
        case .api_MobileType:
            return API.URL_MobileType
        case .api_Country:
            return API.URL_Country
        case .api_buyList:
            return API.URL_BuyList
        case .api_transactInfo:
            return API.URL_TransactInfo
        case .api_postCode:
            return API.URL_PostCode
        case .api_setPayPass:
            return API.URL_SetPayPass
        case .api_forgetPayPass:
            return API.URL_ForgetPayPass
        case .api_authentication:
            return API.URL_Authentication
        case .api_Purchase:
            return API.URL_Purchase
        case .api_PurchaseDetails:
            return API.URL_PurchaseDetails
        case .api_PayType:
            return API.URL_PayType
        case .api_FirstPass:
            return API.URL_FirstPass
        case .api_MyAD:
            return API.URL_MyAD
        case .api_CreateOrder:
            return API.URL_CreateOrder
        default:
            return ""
        }

    
    }
    
    public var method:Moya.Method{
            return .post
    }
    
    public var parameters:[String: Any]?{
        var params = [String: Any]()
        switch self {
        case let .api_Login(param):
             params =  param
        case let .api_register(param):
            params =  param
        case let .api_forgetPass(param):
            params =  param
        case let .api_changePass(param):
            params =  param
        case let .api_registerFister(param):
            params =  param
        case let .api_release(param):
            params = param
        case let .api_MobileType(langId):
            params = ["lang":langId]
        case let .api_Country(langId):
            params = ["lang":langId]
        case let .api_buyList(param):
            params =  param
        case let .api_transactInfo(transactId):
            params = ["id":transactId]
            
        case let .api_postCode(mobile):
            params = ["mobile":mobile]
        case let .api_setPayPass(param):
            params =  param
        case let .api_forgetPayPass(param):
            params =  param
        case let .api_authentication(idcard,name,member_id):
            params = ["idcard":idcard,"name":name,"member_id":member_id]
        case let .api_Purchase(type,member_id):
            params = ["type":type,"member_id":member_id]
        case let .api_PurchaseDetails(id):
            params = ["id":id]
        case let .api_PayType(payment,id):
            params = ["payment":payment,"id":id]
        case let .api_FirstPass(old_pass,type,member_id):
            params = ["old_pass":old_pass,"type":type,"member_id":member_id]
        case let .api_MyAD(is_del,member_id):
            params = ["is_del":is_del,"member_id":member_id]
        case let .api_CreateOrder(product_id,price,coin_num,member_id):
            params = ["product_id":product_id,
                      "price":price,
                      "coin_num":coin_num,
                      "member_id":member_id]
        }

        let date = Date.init()
        let date_str =   date.toString(format: "yyyyMMddHHmmss")
        
        
        params["timestamp"]     = date_str
        params["client_type"]   = "ios"
        params["client_id"]     = BSUserManager.deviceToken
        let infoDic = Bundle.main.infoDictionary
        let appVersion = infoDic?["CFBundleShortVersionString"] ?? ""// 获取App的版本
        params["client_version"]    = appVersion
        /*------params 为接口本身需要的参数----*/
        
        let params_str =  params.formatJSON()
        let encrypptString = AA3DESManager.getEncryptWith(params_str, keyString: DES_KEY, ivString: DES_IV)
        /*------post_params 为请求服务器所定义的接口格式----*/
        var post_params         = [String: Any]()
        post_params["code"]     = "asasasasas"
        post_params["cmd"]      = encrypptString
        post_params["action"]   = self.path
        post_params["sign"]     = self.formatParams(post_params).md5
        
        return post_params
    }
    
    func formatParams(_ params:[String: Any]) -> String {
        var str = ""
        let _ = params.toArray { (key, vulue)  in
            let vulue_str = vulue as? String
            if let s = vulue_str {
                str += (key + "=" + s)
                str = str + "&"
            }
            
        }
        str.removeLast()
        return str + "COIN_MART"
    }
    
    //  单元测试用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var parameterEncoding: ParameterEncoding {
        
        return URLEncoding.default
        
    }
    
    func getUserAgent() -> String {
        let sysName = UIDevice.current.systemName //获取系统名称 例如：iPhone OS
        let sysVersion = UIDevice.current.systemVersion //获取系统版本 例如：9.2
        let deviceModel = UIDevice.current.model //获取设备的型号 例如：iPhone

        let user_Agent = String(format: "apple/%@/%@/%@/%@", deviceModel, sysName, sysVersion)
        return user_Agent
    }
}

