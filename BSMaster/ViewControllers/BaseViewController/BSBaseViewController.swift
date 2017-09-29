//
//  BSBaseViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    deinit {
        
        BSLog("Title: == \(String(describing: self.title)) VC: == \(self.identifier())  --- 销毁")
        
    }

}
