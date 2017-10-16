//
//  BSPostViewModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPostViewModel: NSObject {

//        let signInEnabled: Driver<Bool>
    
//        init(input: (nameInput: Driver<String>, codeInput: Driver<String>,isSelect:Driver<Bool>)) {
//            //判断姓名是否合法
//            let  nameValid = input.nameInput
//                .map { $0.characters.count > 0 }
//            //判断身份证号码是否合法
//            let codeValid = input.codeInput
//                .map{$0.characters.count >= 6 && $0.characters.count < 16 }
//            //判断控制同意协议 按钮的状态
//
//            let checkBtnValid = input.isSelect.map{ $0 }
//
//            signInEnabled = Driver.combineLatest(nameValid, codeValid, checkBtnValid) { (nameValid, codeValid, checkBtnValid) -> Bool in
//                nameValid && codeValid && checkBtnValid
//                }.distinctUntilChanged() //  distinctUntilChanged 会废弃掉重复的事件
//
//        }
        // 发布购买广告接口
        func requestPostBuyAdData(_ params: [String: Any]) -> Observable<String> {
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
