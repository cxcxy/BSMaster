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
        setCustomerBack()
        setUI()
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    func setUI()  {
//        self.view.backgroundColor = UIColor.red
    }
    func setCustomerBack() {
        if let count = navigationController?.viewControllers.count {
            if count > 1 {
                let item = UIBarButtonItem(image:UIImage(named: "nav_Back"), style:.plain, target: self, action:#selector(navBack))
                navigationItem.leftBarButtonItem = item
            }
        }
    }
    func navBack() {
        _ = navigationController?.popViewController(animated: true)
    }
    deinit {
        
        BSLog("Title: == \(String(describing: self.title)) VC: == \(self.identifier())  --- 销毁")
        
    }

}
