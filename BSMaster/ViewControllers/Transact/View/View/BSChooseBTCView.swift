//
//  BSChooseBTCView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/17.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSChooseBTCView: UIView ,CAAnimationDelegate{

    @IBOutlet weak var btnBKB: UIButton!
    @IBOutlet weak var btnLTB: UIButton!
 
    @IBOutlet weak var btnYTF: UIButton!
    @IBOutlet weak var btnBA: UIButton!
    @IBOutlet weak var btnBtc: UIButton!
    func showView(){ // 弹出视图
     
            let animation = CATransition.init()
            animation.delegate = self
            animation.duration = kDuration
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.type = kCATransitionMoveIn;
            animation.subtype = kCATransitionFromLeft
            self.layer.add(animation, forKey: "LocateViewTop")
            self.alpha = 1.0
//            self.view.addSubview(containsView)
        
        
    }
    func dissView(){// 消失视图
        
//        if let containsView = containsView {
            let animation = CATransition.init()
            animation.delegate = self
            animation.duration = kDuration
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.type = kCATransitionPush;
            animation.subtype = kCATransitionFromRight
            self.layer.add(animation, forKey: "LocateViewTop")
            self.alpha = 0.0
//
        }
}
