//
//  BSOrderViewControllers.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/30.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSOrderViewControllers: BSBaseSegmentedControl {

    override func viewDidLoad() {
        super.viewDidLoad()

        configViewControllers()
        self.segmentStyle = .none
    }
    
    func configViewControllers()  {
        self.titleSegmentArray = ["进行中","已结束"]
        var vcArray:[UIViewController] = []
        for _ in titleSegmentArray {
            let HomeTabVC = BSOrderViewController.init(style: .grouped)
            vcArray.append(HomeTabVC)
        }
        self.controllerArray = vcArray
        self.updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
