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
        
        makeCustomerImageNavigationItem("search_white", left: false) {
//            VCRouter.toADVC(.Search)
            VCRouter.toLoginVC()
        }
    }

    lazy var rightNagationItem:BSCountryNavView = {
        let view = BSCountryNavView.loadFromNib()
        view.backgroundColor = BSNavColor
        view.addAction {
        print("click view")
//         VCRouter.toLoginVC()
        VCRouter.toCountryVC()
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

