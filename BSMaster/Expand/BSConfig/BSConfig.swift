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

let Noti_ChangeCoinType     = "kNotificationCoinTypeName"

let Noti_ChooseCountry      = "kNotificationCountryName"

let Noti_RefreshPrice      = "kNotificationRefreshPrice"

let BSPayTypeArr:Array<String> = ["现金存款","银行转账","支付宝","微信支付","其他"]

let BSNoDataTitle:NSAttributedString =   NSAttributedString(string: "暂无数据", attributes:[NSForegroundColorAttributeName:MGRgb(25, g: 28, b: 39),NSFontAttributeName:UIFont.systemFont(ofSize: 17)])


//MARK: 全局统一  Color  风格
    //TODO: 全局tableView 背景色
let tableColor =    MGRgb(238, g: 241, b: 243, alpha: 1.0)
let SeprateColor = UIColor.blue // 系统分割线颜色


//MARK: 导航栏背景色

let BSNavColor = UIColor.init(hexString: "38a1f3")!
//MARK: 下一步按钮背景色

let BSBtnColor = UIColor.init(hexString: "1798f2")!

//MARK: 控件描边颜色
let BSBorderColor = UIColor.init(hexString: "c4c7ce")!

//MARK: tableViewCell Line颜色
let BSCellLineColor = MGRgb(221, g: 226, b: 228)



