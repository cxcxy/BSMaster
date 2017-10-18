//
//  BSMyViewModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
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
    // 实名认证接口
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
//MARK: 我购买的
class BSMyADViewModel: NSObject {
  
    //TODO:  我购买的 列表页 type：状态 1进行中 2已结束
   class func requestMyADListData(_ type:String,member_id:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            BSNetManager.sharedManager.requestWithTarget(.api_Purchase(type:type,member_id:member_id),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            
            return Disposables.create {
            }
        }
    }
}
