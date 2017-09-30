//
//  BSSegmented.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/30.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

extension UISegmentedControl {

    // 当segment值改变时
    func handelSegementControlAction(_ segment:UISegmentedControl)  {
        if let closure = ActionManager.sharedManager.actionDict[NSValue(nonretainedObject: segment)]{
            closure(segment.selectedSegmentIndex)
        }else{
            
        }
    }
    
    //MARK: addSelectorAction
    func  addSelectorAction(_ closure:@escaping (_ selectorIndex: Int)->()){
        
         self.addTarget(self, action: #selector(handelSegementControlAction(_ :)), for: UIControlEvents.valueChanged)
        ActionManager.sharedManager.actionDict[NSValue(nonretainedObject: self)] = closure
    }
    
}
// 全局 block 管理工具
class ActionManager:NSObject{
    var actionDict:Dictionary<NSValue,(_ selectorIndex: Int)->()> = Dictionary()
    static let sharedManager = ActionManager()
    override fileprivate init(){}
}
