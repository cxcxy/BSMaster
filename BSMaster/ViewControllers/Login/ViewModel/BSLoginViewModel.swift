//
//  LoginViewModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/11.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
class BSLoginViewModel {
    let signInEnabled: Driver<Bool>
    
    init(input: (username: Driver<String>, password: Driver<String>)) {
        //判断手机是否合法
        let  phoneValid = input.username
            .map { $0.characters.count > 0 && $0.characters.count <= 11}
        //判断密码是否合法
        let passwordValid = input.password
            .map{$0.characters.count >= 6 && $0.characters.count < 16 }  //map函数 对text进行处理
        
        signInEnabled = Driver.combineLatest(phoneValid, passwordValid) { (usernameValid, passwordValid) -> Bool in
            usernameValid && passwordValid
        }.distinctUntilChanged() //  distinctUntilChanged 会废弃掉重复的事件

    }
}
