//
//  BSPostModel.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPostModel: NSObject {
    var title:String        = ""
    var content:String      = ""
    var imgRight:Bool       =  false
    var plactHold:String    = ""
   
    init(title:String, content:String,placHold:String,imgRight:Bool = false) {
        self.title          = title
        self.content        = content
        self.plactHold      = placHold
        self.imgRight = imgRight
        
    }
}
