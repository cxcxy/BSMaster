//
//  UIViewController+Extension.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
extension UIViewController {
    // 反射拿到类名
    func identifier() -> String {
        let mirror = Mirror(reflecting: self)
        return String(describing: mirror.subjectType)
    }
}
