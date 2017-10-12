//
//  BSNetManager.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

typealias FailClosure               = (_ errorMsg:String?) -> ()
typealias SuccessClosure            = (_ result:AnyObject, _ code: Int?,_ message: String?) ->()

enum RequestCode:String{
    
    case FailError              = "40000"
    case Success                = "0"           //数据请求成功


}
//MARK:前后端约定的返回数据结构
class ReturnInfo: Mappable {
    var data:AnyObject? //若返回无数据，returnObject字段也得带上,可为空值
    var code: Int?
    var message: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        data          <-    map["data"]
        code          <-    map["code"]
        message       <-    map["msg"]
    }
}
class BSNetManager {
    static let sharedManager = BSNetManager()
    fileprivate init(){}
    public static func endpointClosure(target: RequestApi) -> Endpoint<RequestApi> {
        let method = target.method
        let parameters = target.parameters
        let endpoint = Endpoint<RequestApi>(url: target.baseURL.appendingPathComponent(target.path).absoluteString, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: method, parameters: parameters, parameterEncoding: target.parameterEncoding)
        return endpoint
    }
    
    let requestProvider = MoyaProvider<RequestApi>(endpointClosure: BSNetManager.endpointClosure)
    
    func requestWithTarget(
        _ target:RequestApi,
        isShowLoding:Bool = false,
        successClosure:@escaping SuccessClosure,
        failClosure:@escaping FailClosure
        ){
        
        if isShowLoding {
            BSHud.showLoading()
        }
        
        BSLog("request target 请求的URL： \(target.path)\n请求的参数：\(target.parameters ?? [:])")
        _ =  requestProvider.request(target) { (result) in

            BSHud.dismiss()
            switch result{
                
            case let .success(response):
                
                _ = response.data
                _ = response.statusCode
                
                var jsonString      = ""

                jsonString      = try! response.mapString()
                
                let info = Mapper<ReturnInfo>().map(JSONString:jsonString)
                BSLog(jsonString)
                if let code = info?.code{
                    
                    guard code == 200 else{
                       
                        failClosure(info?.message)
                        
                        return
                    }
                }else{

                    return
                }

                let res = info?.data ?? [] as AnyObject
                successClosure(res, info?.code,info?.message)
                
            case .failure(_):
                failClosure("网络错误")
                break
            }
        }
    }
}
