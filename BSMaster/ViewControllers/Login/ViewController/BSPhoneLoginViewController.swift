//
//  BSPhoneLoginViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/9.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPhoneLoginViewController: BSBaseViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnPassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
    }
    override func setUI() {
        super.setUI()
        
        makeCustomerNavigationItem("注册", left: false) {
            VCRouter.toRegistVC()
        }
        btnLogin.addBorder(width: 0.5, color: BSBorderColor)
        btnLogin.layer.cornerRadius         = 7.0
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
