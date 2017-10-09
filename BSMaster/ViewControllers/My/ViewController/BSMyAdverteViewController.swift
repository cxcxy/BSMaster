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
        var vcArray:[UIViewController] = []
        for _ in titleVCSegmentArray {
            let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSPhoneLoginViewController")
            vcArray.append(vc)
        }
        self.controllerArray  = vcArray
        self.segmentStyle     = .headerView
        self.updateUI()
    }
    // 根据不同的界面配置不同的文字
    func configTitleArray()  {
        var titleArray:Array<String> = []
        switch controllerStyle {
        case .Adverted:
            titleArray      = ["进行中","已下架"]
        case .Trust:
            titleArray      = ["您信任的人","信任您的人"]
        case .Buy,.Sold:
            titleArray      = ["进行中","已结束"]
        }
        self.titleVCSegmentArray       = titleArray
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
