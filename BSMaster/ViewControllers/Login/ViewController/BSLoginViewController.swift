//
//  BSLoginViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/9.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSLoginViewController: BSBaseSegmentedControl {

    override func viewDidLoad() {
        super.viewDidLoad()
        configViewControllers()
    }
    func configViewControllers()  {
        self.titleVCSegmentArray       = ["手机登录","邮箱登录"]
        var vcArray:[UIViewController] = []
        for _ in titleVCSegmentArray {
            let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSPhoneLoginViewController")
            vcArray.append(vc)
        }
        self.controllerArray  = vcArray
        self.segmentStyle     = .headerView
        self.updateUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
