//
//  BSViewComponent.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/11.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
// 全局 block 管理工具
class ActionSegmentManager:NSObject{
    var actionDict:Dictionary<NSValue,(_ selectorIndex: Int)->()> = Dictionary()
    static let sharedManager = ActionSegmentManager()
    override fileprivate init(){}
}


extension UISegmentedControl {
    
    // 当segment值改变时
    func handelSegementControlAction(_ segment:UISegmentedControl)  {
        if let closure = ActionSegmentManager.sharedManager.actionDict[NSValue(nonretainedObject: segment)]{
            closure(segment.selectedSegmentIndex)
        }else{
            
        }
    }
    
    //MARK: addSelectorAction
    func  addSelectorAction(_ closure:@escaping (_ selectorIndex: Int)->()){
        
        self.addTarget(self, action: #selector(handelSegementControlAction(_ :)), for: UIControlEvents.valueChanged)
        ActionSegmentManager.sharedManager.actionDict[NSValue(nonretainedObject: self)] = closure
    }
    
}

class BSNextBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor            = UIColor.white
        self.layer.cornerRadius         = 7.0
        self.addBorder(width: 0.5, color: BSBorderColor)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(MGRgb(193, g: 197, b: 204), for: .disabled)
        self.setBackgroundColor(BSBtnColor, forState: .normal)
        self.setBackgroundColor(UIColor.white, forState: .disabled)
//        self.setTitleColor(UIColor.init(hexString: "c1c5cc"), for: .normal)
    }
    
}
