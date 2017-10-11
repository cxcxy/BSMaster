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
public let MGScreenWidth:CGFloat = UIScreen.main.bounds.size.width
public let MGScreenHeight:CGFloat = UIScreen.main.bounds.size.height
public let MGScreenWidthHalf:CGFloat = MGScreenWidth / 2
public let MGScreenHeightHalf:CGFloat = MGScreenHeight / 2

public func BSRgb(_ r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat = 1) -> UIColor{
    return UIColor(red:r/255.0, green: g/255.0, blue: b/255.0, alpha:alpha)
}
//MARK: 全局统一  Color  风格
    //TODO: 全局tableView 背景色
let tableColor = UIColor.darkGray
let SeprateColor = UIColor.blue // 系统分割线颜色


//MARK: 导航栏背景色

let BSNavColor = UIColor.init(hexString: "1798f2")
//MARK: 下一步按钮背景色

let BSBtnColor = UIColor.init(hexString: "38a1f3")
//MARK: 控件描边颜色

let BSBorderColor = UIColor.init(hexString: "c4c7ce")!
