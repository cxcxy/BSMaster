//
//  BSTransactViewControllers.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/30.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import VTMagic

class BSTransactViewControllers: BSBaseSegmentedControl {


    override func viewDidLoad() {
        super.viewDidLoad()
        configViewControllers()
    }

    func configViewControllers()  {
        self.titleSegmentArray = ["买币","卖币"]
        var vcArray:[UIViewController] = []
        for _ in titleSegmentArray {
            let HomeTabVC = UIStoryboard.getStoryVC(.Transact, identifier: "BSTransactViewController")
            vcArray.append(HomeTabVC)
        }
        self.controllerArray = vcArray

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
}

