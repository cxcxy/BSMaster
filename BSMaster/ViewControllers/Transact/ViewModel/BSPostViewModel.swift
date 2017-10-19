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
class BSTransactDetailViewModel: NSObject {
    
    
    //MARK: 交易详情接口
    class  func requestTransactDetailData(_ transact: String) -> Observable<BSTransactDetailModel> {
        return Observable.create { observer -> Disposable in
            
            BSNetManager.sharedManager.requestWithTarget(.api_transactInfo(transactId: transact),isShowLoding: true, successClosure: { (result, code,message)  in
 
                let model = Mapper<BSTransactDetailModel>().map(JSONObject: result)
                if let m = model{
                    observer.onNext(m)
                }
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            
            return Disposables.create {
            }
            
        }
    }
    //MARK: 购买／出售接口
    class  func requestCreateOrderData(_ product_id:String,price:String,coin_num:String,member_id:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            
            BSNetManager.sharedManager.requestWithTarget(.api_CreateOrder(product_id:product_id,price:price,coin_num:coin_num,member_id:member_id),isShowLoding: true, successClosure: { (result, code,message)  in

                if let m = message{
                    observer.onNext(m)
                }
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            
            return Disposables.create {
            }
            
        }
    }
    
}
