//
//  BSMyViewModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

public enum RefreshStatus: Int {
    case PushSuccess
    case PushFailure
    case PullSuccess
    case PullFailure
    case NoMoreData
    case Unknown
}

//MARK:实名认证
class BSRealNameViewModel: NSObject {
    let signInEnabled: Driver<Bool>
    
    init(input: (nameInput: Driver<String>, codeInput: Driver<String>,isSelect:Driver<Bool>)) {
        //判断姓名是否合法
        let  nameValid = input.nameInput
            .map { $0.characters.count > 0 }
        //判断身份证号码是否合法
        let codeValid = input.codeInput
            .map{$0.characters.count > 0  }
        //判断控制同意协议 按钮的状态
        
        let checkBtnValid = input.isSelect.map{ $0 }
        
        signInEnabled = Driver.combineLatest(nameValid, codeValid, checkBtnValid) { (nameValid, codeValid, checkBtnValid) -> Bool in
            nameValid && codeValid && checkBtnValid
        }.distinctUntilChanged() //  distinctUntilChanged 会废弃掉重复的事件
        
    }
    //TODO: 实名认证接口
    func requestRealNameData(_ idcard:String,name:String,member_id:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
        BSNetManager.sharedManager.requestWithTarget(.api_authentication(idcard:idcard,name:name,member_id:member_id),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            
            return Disposables.create {
            }
        }
    }
}
//MARK: 我的广告
class BSMyADViewModel: NSObject {
    public var refresh:Variable<RefreshStatus> = Variable(.Unknown)
    //TODO:  我的广告 列表页 type：状态 1进行中 2已下架
//    var list :Array<SectionModel<String, BSMyBuyModel>> = []
   public var result:Observable<[SectionModel<String, BSMyBuyModel>]>?
   override init() {
        super.init()
    }
    
   func requestMyADListData(_ id_del:String,member_id:String) -> Observable<[SectionModel<String, BSMyBuyModel>]> {
        return Observable.create { observer -> Disposable in
            BSNetManager.sharedManager.requestWithTarget(.api_MyAD(is_del:id_del,member_id:member_id),isShowLoding: true, successClosure: { (result, code,message)  in
                
                let arr = Mapper<BSMyBuyModel>().mapArray(JSONObject:result)
                if let array = arr{
                    
                    let section = array.transSectionModelArray()
                    self.refresh.value = .PushSuccess
//                    self.result.v
                    observer.onNext(section)
                }
            }) { (errorStr) in
                self.refresh.value = .PushFailure
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            
            return Disposables.create {
            }
        }
    }
    //TODO:  我购买 列表页 type：状态 1进行中 2已结束
    
     func requestMyBuyListData(_ type:String,member_id:String) -> Observable<[SectionModel<String, BSMyBuyModel>]> {
        return Observable.create { observer -> Disposable in
            BSNetManager.sharedManager.requestWithTarget(.api_Purchase(type:type,member_id:member_id),isShowLoding: true, successClosure: { (result, code,message)  in
                
                let arr = Mapper<BSMyBuyModel>().mapArray(JSONObject:result)
                if let array = arr{
                    let section = array.transSectionModelArray()
                    observer.onNext(section)
                }
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            
            return Disposables.create {
            }
        }
    }
    //TODO: 切换我的广告状态 下架等操作
     func requestLowerMyADListData(_ is_del:String,AD_id:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            BSNetManager.sharedManager.requestWithTarget(.api_LowerAD(is_del:is_del,AD_id:AD_id),isShowLoding: true, successClosure: { (result, code,message)  in
                if let str = message {
                    observer.onNext(str)
                }
                
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            
            return Disposables.create {
            }
        }
    }
}

