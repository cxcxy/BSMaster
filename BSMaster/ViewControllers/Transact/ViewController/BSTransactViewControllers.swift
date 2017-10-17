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
    var isShow:Bool = true
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
            VCRouter.toADVC(.Search)
//            VCRouter.toLoginVC()
        }
        configChooseBTCView()
    }

    lazy var rightNagationItem:BSCountryNavView = {
        let view = BSCountryNavView.loadFromNib()
        view.backgroundColor = BSNavColor
        view.addAction {
        print("click view")
//         VCRouter.toLoginVC()
//            VCRouter.toCountryVC(.Country, block: <#ChooseCountryBlock#>)
            VCRouter.toCountryVC(.Country, block: { (str, id,code) in
                view.lbCountryName.text = str
            })
        }
        return view
    }()
    func configViewControllers()  {
        self.titleSegmentArray = [NSLocalizedString("BuyCoins", comment: ""),"卖币"]
        var vcArray:[UIViewController] = []
        for elemt in titleSegmentArray.enumerated() {
            let HomeTabVC = UIStoryboard.getStoryVC(.Transact, identifier: "BSTransactViewController") as! BSTransactViewController
            if elemt.offset == 0 {
                HomeTabVC.transactType = .Buy
            }
            if elemt.offset == 1 {
                HomeTabVC.transactType = .Sold
            }
            vcArray.append(HomeTabVC)
        }
        self.controllerArray = vcArray
        self.updateUI()
        makeRightNavigationItem(rightNagationItem, left: true)

    }
    lazy var btcView: BSChooseBTCView = {
        let v = BSChooseBTCView.loadFromNib()
        return v
    }()
    func configChooseBTCView()  {
        let b               = UIButton(type: .custom)
        b.frame             = CGRect(x: 0, y: 0, width: 50, height: 50)
        b.titleLabel!.font  =  UIFont.systemFont(ofSize: 14)
        b.setTitleColor(MGRgb(128, g: 140, b: 155), for: UIControlState())
        b.setTitleColor(MGRgb(50, g: 164, b: 244), for: .selected)
        b.addTarget(self, action: #selector(showAction), for: .touchUpInside)
        b.backgroundColor = UIColor.blue
        
        self.view.addSubview(b)
        self.view.addSubview(btcView)
        
        b.snp.makeConstraints { [unowned self](make) in
            
            make.width.equalTo(50)
            make.right.equalTo(self.view).offset(-15)
            make.bottom.equalTo(self.view).offset(-200)
            make.height.equalTo(50)
            
        }
        
        btcView.snp.makeConstraints { [unowned self](make) in
            make.width.equalTo(0)
            make.right.equalTo(b).offset(-50)
            make.bottom.equalTo(self.view).offset(-200)
            make.height.equalTo(50)
            
        }
        
    }
    func showAction()  {
        btcView.snp.updateConstraints({ (make) in
            if self.isShow {
                self.isShow = !self.isShow
                make.width.equalTo(0)
            }else {
                self.isShow = !self.isShow
                make.width.equalTo(200)
            }
        })
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
}

