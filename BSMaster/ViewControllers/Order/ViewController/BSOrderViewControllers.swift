//
//  BSOrderViewControllers.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/30.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSOrderViewControllers: BSBaseSegmentedControl {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configViewControllers()
        self.segmentStyle = .none
    }
    
    func configViewControllers()  {
        self.titleSegmentArray = ["进行中","已结束"]
        var vcArray:[UIViewController] = []
        
        for elemt in titleSegmentArray.enumerated() {
            
            let HomeTabVC = BSOrderViewController.init(style: .grouped)
            if elemt.offset == 0 {
                HomeTabVC.orderType = .Progress
            }
            if elemt.offset == 1 {
                HomeTabVC.orderType = .Over
            }
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
