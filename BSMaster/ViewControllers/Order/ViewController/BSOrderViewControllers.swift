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
    }
    
    func configViewControllers()  {
        self.titleSegmentArray = ["进行中","已结束"]
        var vcArray:[UIViewController] = []
        for _ in titleSegmentArray {
            let HomeTabVC = BSOrderViewController()
            vcArray.append(HomeTabVC)
        }
        self.controllerArray = vcArray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
