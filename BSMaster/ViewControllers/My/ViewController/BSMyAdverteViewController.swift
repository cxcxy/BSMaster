//
//  BSMyAdverteViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/9.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
public enum BSSegmentStyle {
    
    case Adverted   // 我的广告
    case Trust      // 受信任的
    case Buy        // 我购买的
    case Sold       // 我出售的
    case Search     // 搜索
    
}
class BSMyAdverteViewController: BSBaseSegmentedControl {
    var controllerStyle : BSSegmentStyle = .Adverted
    override func viewDidLoad() {
        super.viewDidLoad()

        configViewControllers()
        
    }
    func configViewControllers()  {
//        let s  = NSLocalizedString("aDES", comment: <#T##String#>)
        
        configTitleArray()

       
        self.segmentStyle     = .headerView
        self.updateUI()
    }
    // 根据不同的界面配置不同的文字
    func configTitleArray()  {
        var titleArray:Array<String> = []
        var vcArray:[UIViewController] = []
        
        switch controllerStyle {
        case .Adverted:
            self.title      =   "我的广告"
            titleArray      =  ["进行中","已结束"]
            let vc          = BSMyBuyController.init(style: .grouped)
            vc.myType       = .MyADProgress
            let vcTwo       = BSMyBuyController.init(style: .grouped)
            vcTwo.myType    = .MyADOver
            vcArray.append(vc)
            vcArray.append(vcTwo)
        case .Trust:
            titleArray      = ["您信任的人","信任您的人"]
        case .Buy:
            self.title      =   "我购买的"
            titleArray      =  ["进行中","已结束"]
            let vc          = BSMyBuyController.init(style: .grouped)
            vc.myType       = .MyBuyProgress
            let vcTwo       = BSMyBuyController.init(style: .grouped)
            vcTwo.myType    = .MyBuyOver
            vcArray.append(vc)
            vcArray.append(vcTwo)
         case .Sold:
            self.title      =   "我出售的"
            titleArray      =  ["进行中","已结束"]
            let vc          = BSMyBuyController.init(style: .grouped)
            let vcTwo       = BSMyBuyController.init(style: .grouped)
            vcArray.append(vc)
            vcArray.append(vcTwo)
  
        case .Search:
            self.title      = "搜索"
            titleArray      = ["找广告","找用户"]
            let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSSearchController")
            let vcTwo = UIStoryboard.getStoryVC(.Login, identifier: "BSSearchUserController")
            vcArray.append(vc)
            vcArray.append(vcTwo)

        }
        self.titleVCSegmentArray        = titleArray
        self.controllerArray            = vcArray
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
