//
//  BSRegistViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/10.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSRegistViewController: BSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
    }
    override func setUI() {
        super.setUI()
        
        makeCustomerNavigationItem("登录", left: false) {
            VCRouter.toRegistVC()
        }
//        btnLogin.addBorder(width: 0.5, color: BSBorderColor)
//        btnLogin.layer.cornerRadius         = 7.0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
