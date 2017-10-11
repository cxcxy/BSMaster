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
    
}
let provider = RxMoyaProvider<RequestApi>()
extension RequestApi:TargetType{

    public func headers() -> [String: String] {
        var assigned: [String: String] = [:]

        return assigned
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

