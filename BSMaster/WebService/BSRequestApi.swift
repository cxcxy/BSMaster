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
    case api_Login(params: [String: Any])
    case api_register(params: [String: Any])
    case api_forgetPass(params: [String: Any])
    case api_changePass(params: [String: Any])
    case api_registerFister(params: [String: Any])
    case api_release(params: [String: Any])
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
        }
        return params
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
        let infoDic = Bundle.main.infoDictionary
        let appVersion = infoDic?["CFBundleShortVersionString"] ?? ""// 获取App的版本
        let user_Agent = String(format: "apple/%@/%@/%@/%@", deviceModel, sysName, sysVersion, appVersion as! String)
        return user_Agent
    }
}

