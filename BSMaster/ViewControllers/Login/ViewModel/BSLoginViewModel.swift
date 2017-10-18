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
    // 登录接口   mobile_type 默认为中国 44
    func requestLoginData(_ phone:String,password:String,mobile_type:String = "44") -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = mobile_type
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
    //MARK:  注册第一步接口。判断手机号，验证码是否合法。type 1 注册密码 type 2 忘记密码
    class func requestRegisterFisterData(_ phone:String,type:String,verCode:String,mobile_type:String = "44") -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = mobile_type
            params["mobile"]        = phone
            params["type"]          = type
            params["vcode"]         = verCode
//            let model =  BSRegisterFirstModel.init(mobile_type: mobile_type, mobile: phone, type: type, vcode: verCode)
            BSNetManager.sharedManager.requestWithTarget(.api_registerFister(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            return Disposables.create {
            }
        }
    }
    //MARK:  注册接口
   class func requestRegisterData(_ phone:String,password:String,verCode:String,nickName:String,mobile_type:String = "44") -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = mobile_type
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
    
   //MARK:  发送短信接口
    class func requestPoseCodeData(_ phone:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            BSNetManager.sharedManager.requestWithTarget(.api_postCode(mobile: phone),isShowLoding: true, successClosure: { (result, code,message)  in
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

    
    
    //MARK:  忘记 登录 密码接口
    class func requestForgetLoginPassData(_ phone:String,password:String,verCode:String,mobile_type:String = "44") -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = mobile_type
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
    //MARK:  判断原密码 是否正确接口 type 1, 重置资金密码 2 重置支付密码
    class func requestJudgmentOldPassData(_ old_pass:String,type:String,member_id:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            BSNetManager.sharedManager.requestWithTarget(.api_FirstPass(old_pass:old_pass,type:type,member_id:member_id),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            return Disposables.create {
            }
        }
    }
    
    //MARK: 使用原密码 修改 登录密码接口
    class func requestChangePassOldData(_ oldPass:String,password:String,member_id:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["member_id"]           = member_id
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
//
   //MARK:  使用原密码 修改 资金密码接口
    class func requestChangeOldPayPassData(_ oldPass:String,password:String,member_id:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["old_pass"]          = oldPass
            params["member_id"]         = member_id
            params["pay_pass"]          = password
            params["pay_pass1"]         = password

            BSNetManager.sharedManager.requestWithTarget(.api_setPayPass(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            return Disposables.create {
            }
        }
    }
     //MARK: 忘记 资金密码 接口
    class func requestForgetPayPassData(_ phone:String,password:String,verCode:String,mobile_type:String = "44") -> Observable<String> {
        return Observable.create { observer -> Disposable in
            var params = [String:Any]()
            params["mobile_type"]   = mobile_type
            params["mobile"]        = phone
            params["pay_pass"]      = password
            params["pay_pass1"]     = password
            params["vcode"]         = verCode
            
            BSNetManager.sharedManager.requestWithTarget(.api_forgetPayPass(params: params),isShowLoding: true, successClosure: { (result, code,message)  in
                observer.onNext(message ?? "")
            }) { (errorStr) in
                observer.onError(NetError.CustomError(errorStr ?? "").handle())
            }
            return Disposables.create {
            }
        }
    }
}


class BSMobileListViewModel {
    
    //MARK: 获取国家／区号 数据接口
    class func requestMobileListData(_ lang:String?) -> Observable<[BSMobileListModel]> {
        return Observable.create { observer -> Disposable in
  
            BSNetManager.sharedManager.requestWithTarget(.api_MobileType(lang: lang ?? "4"),isShowLoding: true, successClosure: { (result, code,message)  in

                let arr = Mapper<BSMobileListModel>().mapArray(JSONObject:result)
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
    //MARK: 获取货币类型 数据接口
    class func requestCurrencyListData(_ lang:String?) -> Observable<[BSMobileListModel]> {
        return Observable.create { observer -> Disposable in
            
            BSNetManager.sharedManager.requestWithTarget(.api_Country(lang: lang ?? "4"),isShowLoding: true, successClosure: { (result, code,message)  in
               
                let dic = result as? NSDictionary
                let ar = dic?.allValues
                
                let arr = Mapper<BSMobileListModel>().mapArray(JSONObject:ar)
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



