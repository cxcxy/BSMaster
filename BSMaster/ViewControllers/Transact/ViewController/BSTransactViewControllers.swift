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
        self.segmentStyle = .none
        
        makeCustomerImageNavigationItem("search_white", left: false) {
            VCRouter.toADVC(.Search)
        }
    }
    
    
//    func requstLogin()  {
//        var params = [String:Any]()
////        params["mobile_type"]   = "1"
//        params["mobile"]        = "15981870364"
//        params["login_pass"]    = "123456"
////        params["vcode"]         = "123456"
////        params["nickname"]      = "cxcxcxy"
//        BSNetManager.sharedManager.requestWithTarget(.api_Login(params: params), successClosure: { (result, code,message)  in
//            
//           BSHud.showMsg(message)
//            
//        }) { (errorStr) in
//            print(errorStr ?? "error")
//        }
//    }
    
    
    
    lazy var rightNagationItem:BSCountryNavView = {
        let view = BSCountryNavView.loadFromNib()
        view.backgroundColor = BSNavColor
        view.addAction {
            print("click view")
//            self.requstLogin()
         VCRouter.toLoginVC()
        }
        return view
    }()
    func configViewControllers()  {
        self.titleSegmentArray = [NSLocalizedString("BuyCoins", comment: ""),"卖币"]
        var vcArray:[UIViewController] = []
        for _ in titleSegmentArray {
            let HomeTabVC = UIStoryboard.getStoryVC(.Transact, identifier: "BSTransactViewController")
            vcArray.append(HomeTabVC)
        }
        self.controllerArray = vcArray
        self.updateUI()
        makeRightNavigationItem(rightNagationItem, left: true)

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
}

