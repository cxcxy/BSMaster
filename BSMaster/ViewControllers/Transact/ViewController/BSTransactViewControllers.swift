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
//            VCRouter.toADVC(.Search)
            
    
            self.toRCMessageVC()
//            VCRouter.toLoginVC()
        }
        configChooseBTCView()
    }

    
    func toRCMessageVC()  {
        let vc = BSRCMessageViewController()
        vc.conversationType =  RCConversationType.ConversationType_PRIVATE
        vc.targetId = "1"
        vc.title = "出售订单"
        self.pushVC(vc)
    }
    
    lazy var rightNagationItem:BSCountryNavView = {
        let view = BSCountryNavView.loadFromNib()
        view.backgroundColor = BSNavColor
        view.addAction {

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
    // 选择币种按钮
    lazy var chooseBtn: UIButton = {
       let b                = UIButton(type: .custom)
        b.frame             = CGRect(x: 0, y: 0, width: 50, height: 50)
        b.addTarget(self, action: #selector(showAction), for: .touchUpInside)
        b.setImage(UIImage.init(named: "coin_btc"), for: UIControlState())
        b.setBackgroundImage(UIImage.init(named: "toggle_coin"), for: UIControlState())
        return b
    }()
    // 展开选择币种View
    func configChooseBTCView()  {
        self.view.addSubview(btcView)
        self.view.addSubview(chooseBtn)
        chooseBtn.snp.makeConstraints { [unowned self](make) in
            
            make.width.equalTo(50)
            make.right.equalTo(self.view).offset(-15)
            make.bottom.equalTo(self.view).offset(-200)
            make.height.equalTo(50)
            
        }
        
        btcView.snp.makeConstraints { [unowned self](make) in
            make.width.equalTo(0)
            make.right.equalTo(self.chooseBtn).offset(-25)
            make.bottom.equalTo(self.view).offset(-200)
            make.height.equalTo(50)
            
        }
        
        btcView.btnBtc.addAction {  [unowned self] in
            self.configBtnImg(0)
        }
        btcView.btnLTB.addAction {  [unowned self] in
            self.configBtnImg(1)
        }
        btcView.btnYTF.addAction {  [unowned self] in
            self.configBtnImg(2)
        }
        btcView.btnBA.addAction {  [unowned self] in
            self.configBtnImg(3)
        }
        btcView.btnBKB.addAction {  [unowned self] in
            self.configBtnImg(4)
        }
        
//        btcView.setCornerRadius(radius: 5.0)
        
    }
    // 控制展开收起
    func showAction()  {
        btcView.snp.updateConstraints({ (make) in
            if self.isShow {
                self.isShow = !self.isShow
                make.width.equalTo(230)
            }else {
                self.isShow = !self.isShow
                make.width.equalTo(0)
            }
        })
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    // 配置选择按钮的图片切换
    func configBtnImg(_ index:Int)  {
        let imgArray = ["coin_ltc","coin_ytf","coin_bei","coin_ba","coin_btc"]
        chooseBtn.setImage(UIImage.init(named: imgArray[index]), for: UIControlState())
        // 发送通知：
        let dic = ["coin_type":index + 1]
        
        NotificationCenter.postNotificationNameOnMainThread(Noti_ChangeCoinType, object: dic)
        
        self.showAction()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
}

