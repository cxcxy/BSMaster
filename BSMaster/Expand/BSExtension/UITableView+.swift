//
//  UITableView+.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
public extension UINib{
    // 通过name 取Nib
    class func nibName(_ name:String) ->UINib{
        return UINib(nibName: name, bundle: Bundle.main)
    }
}

extension UITableView {
    // 注册CellId -Nib
    func cellId_register(_ cellId:String)    {
        self.register(UINib.nibName(cellId), forCellReuseIdentifier: cellId)
    }
    
    
}
extension UICollectionView {
   // 注册CellId -Nib
    func cellId_register(_ cellId:String)    {
        self.register(UINib.nibName(cellId), forCellWithReuseIdentifier: cellId)
    }
    
}
