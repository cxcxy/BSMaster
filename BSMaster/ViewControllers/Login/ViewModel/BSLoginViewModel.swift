//
//  LoginViewModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/11.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
public enum NetError:Swift.Error {
    
    case HTTPError(NSError)
    case CustomError(String)
    case DataError
    func handle() -> NetError {
        switch self {
        case NetError.CustomError(let errorMsg):
            BSHud.showWarnMsg(errorMsg)
        default:
            break
        }
        return self
    }
}

class BSLoginViewModel {
    let signInEnabled: Driver<Bool>
    
    init(input: (phoneNumber: Driver<String>, password: Driver<String>)) {
        //判断手机是否合法
        let  phoneValid = input.phoneNumber
            .map { $0.characters.count > 0 && $0.characters.count <= 11}
        //判断密码是否合法
        let passwordValid = input.password
            .map{$0.characters.count >= 6 && $0.characters.count < 16 }
        
        signInEnabled = Driver.combineLatest(phoneValid, passwordValid) { (usernameValid, passwordValid) -> Bool in
            usernameValid && passwordValid
        }.distinctUntilChanged() //  distinctUntilChanged 会废弃掉重复的事件

    }
    // 登录接口 
    func requestLoginData(_ phone:String,password:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = "1"
            params["mobile"]        = phone
            params["login_pass"]    = password
            BSNetManager.sharedManager.requestWithTarget(.api_Login(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }

            return Disposables.create {
            }
            
        }
    }
}
class BSRegisterViewModel {
    let nextInEnabled: Driver<Bool>
    
    init(input: (phoneNumber: Driver<String>, password: Driver<String>,verCode: Driver<String> ,isSelect:Driver<Bool>)) {
        //判断手机是否合法
        let phoneValid = input.phoneNumber
            .map { $0.characters.count > 0 && $0.characters.count <= 11}
        //判断密码是否合法
        let passwordValid = input.password
            .map{$0.characters.count >= 6 && $0.characters.count < 16 }
    
        //判断验证码是否合法
        let codeValid = input.verCode
            .map{$0.characters.count > 0 && $0.characters.count <= 6 }
        
        //判断控制同意协议 按钮的状态
        
        let checkBtnValid = input.isSelect.map{ $0 }
        
        nextInEnabled = Driver.combineLatest(phoneValid, passwordValid, codeValid, checkBtnValid) { (usernameValid, passwordValid, codeValid, checkBtnValid) -> Bool in
            usernameValid && passwordValid && codeValid && checkBtnValid
         }.distinctUntilChanged() //  distinctUntilChanged 会废弃掉重复的事件
        
    }
    // 注册第一步接口。判断手机号，验证码是否合法
    class func requestRegisterFisterData(_ phone:String,type:String,verCode:String,mobile_type:String?) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = mobile_type ?? "1"
            params["mobile"]        = phone
            params["type"]          = type
            params["vcode"]         = verCode

            BSNetManager.sharedManager.requestWithTarget(.api_registerFister(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            return Disposables.create {
            }
        }
    }
    // 注册接口
   class func requestRegisterData(_ phone:String,password:String,verCode:String,nickName:String,mobile_type:String?) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = mobile_type ?? "1"
            params["mobile"]        = phone
            params["login_pass"]    = password
            params["vcode"]         = verCode
            params["nickname"]      = nickName
            BSNetManager.sharedManager.requestWithTarget(.api_register(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            return Disposables.create {
            }
        }
    }
}


class BSPassViewModel {

    // 重置密码接口
    class func requestResetPassData(_ phone:String,password:String,verCode:String,mobile_type:String?) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = mobile_type ?? "1"
            params["mobile"]        = phone
            params["pass1"]         = password
            params["pass2"]         = password
            params["vcode"]         = verCode
            BSNetManager.sharedManager.requestWithTarget(.api_forgetPass(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            return Disposables.create {
            }
        }
    }
    // 修改登录接口
    class func requestChangePassData(_ phone:String,oldPass:String,password:String,token:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["token"]         = token
            params["pass_old"]      = oldPass
            params["pass1"]         = password
            params["pass2"]         = password

            BSNetManager.sharedManager.requestWithTarget(.api_changePass(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            return Disposables.create {
            }
        }
    }
}






