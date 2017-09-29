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
    
}
let provider = RxMoyaProvider<RequestApi>()
extension RequestApi:TargetType{

    public func headers() -> [String: String] {
        var assigned: [String: String] = [:]
        
        assigned += ["User-Agent": getUserAgent()]
        return assigned
    }
    
    public var task: Task {
         return .request
    }
    
    public var baseURL:URL{
        return URL(string: BaseUrl)!
    }
    
    public var path:String{
      
       return ""
    
    }
    
    public var method:Moya.Method{
//        switch self {
        
//        default:
            return .post
//        }
        
    }
    
    public var parameters:[String: Any]?{
 
        return nil
        
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

