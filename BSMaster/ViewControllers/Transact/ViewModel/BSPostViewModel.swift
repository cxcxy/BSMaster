//
//  BSPostViewModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPostViewModel: NSObject {


        // 发布购买广告接口
      class  func requestPostBuyAdData(_ params: [String: Any]) -> Observable<String> {
            return Observable.create { observer -> Disposable in
                
                BSNetManager.sharedManager.requestWithTarget(.api_release(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                    observer.onNext(message ?? "")
                }) { (errorStr) in
                    observer.onError(NetError.CustomError(errorStr ?? "").handle())
                }
                
                return Disposables.create {
                }
                
            }
        }
    
}
class BSPostListViewModel: NSObject {
    
    
    // 买币列表接口
    class  func requestBuyListData(_ params: [String: Any]) -> Observable<[BSPostListModel]> {
        return Observable.create { observer -> Disposable in
            
            BSNetManager.sharedManager.requestWithTarget(.api_buyList(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
//                observer.onNext(message ?? "")
            
//                let a = IXON(result)
//                let a result.toJSON
//                print(re s)
                let r = JSON(result)
                let arr = Mapper<BSPostListModel>().mapArray(JSONObject:r["list"].arrayObject)
                if let array = arr{
                    observer.onNext(array)
                }
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            
            return Disposables.create {
            }
            
        }
    }
    
}
