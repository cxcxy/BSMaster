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
public func BSLog (_ value: Any , fileName : String = #file, line : Int32 = #line ){
    /// Debug Log
    if BSDEBUG {
        print("file：\(URL(string: fileName)!.lastPathComponent)  line：\(line) \(value)\n")
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

enum StoryBoardNames: String {

    case Main
    case Store

}


let currentPageSize = 10   // 全局分页数





