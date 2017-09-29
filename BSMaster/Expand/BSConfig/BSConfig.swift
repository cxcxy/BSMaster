//
//  BSConfig.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation

//MARK:  print -- log
let BSDEBUG = true
public func BSLog<T> (_ value: T , fileName : String = #file, function:String = #function, line : Int32 = #line ){
 
    if BSDEBUG {
        print("file：\(URL(string: fileName)!.lastPathComponent) line:- \(line) function:- \(function) | \(value)\n")
    }
}
//MARK:   延迟多少秒 回掉
struct BSDelay {
    static func start(delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
}
//MARK: 全局统一  Color  风格
    //TODO: 全局tableView 背景色
let tableColor = UIColor.darkGray
let SeprateColor = UIColor.blue // 系统分割线颜色


