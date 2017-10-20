//
//  BSRCMessageViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/18.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
struct BSBuyInfoModel {
    var price:String
    var quota:String
    var type:String
}
enum RCCloudType {
    case Buy          // 购买
    case Consulting   // 咨询
}

class BSRCMessageViewController: RCConversationViewController {

    var ccloudType:RCCloudType = .Consulting
    var buyInfoModel : BSBuyInfoModel?
    var v : UIView! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCustomerNavigationItem("帮助", left: false) {[unowned self] in
            self.updateVFrame()
        }
    }
    func updateVFrame()  {
        v.frame.y = -64 
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         configUI()
    }
    // 获取咨询 顶部view布局
    func getMessageHeaderView() -> BSMessageHeaderView {
        let  v = BSMessageHeaderView.loadFromNib()
        if let m = buyInfoModel {
            v.buyInfoModel = m
        }
        return v
    }
    func configUI()  {
        let nav_h:CGFloat = 64
        var v_h:CGFloat   = 0
      

        switch ccloudType {
        case .Consulting:
                v_h = 80
                v = self.getMessageHeaderView()
            break
        case .Buy:
                v_h = 360
                v = BSMessageProgressView.loadFromNib()
        }
     
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.height.equalTo(v_h)
            make.width.equalTo(MGScreenWidth)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(nav_h)
        }
        self.conversationMessageCollectionView.frame = CGRect.init(x: 0,
                                                                   y: nav_h + v_h,
                                                                   w: MGScreenWidth,
                                                                   h: MGScreenHeight - v_h - nav_h - 44)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
