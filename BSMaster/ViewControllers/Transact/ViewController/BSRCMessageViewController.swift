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


class BSRCMessageViewController: RCConversationViewController {

    
    var buyInfoModel : BSBuyInfoModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        makeCustomerNavigationItem("帮助", left: false) {
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         configUI()
    }
    func configUI()  {
        let v = BSMessageHeaderView.loadFromNib()
        if let m = buyInfoModel {
            v.buyInfoModel = m
        }
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.height.equalTo(80)
            make.width.equalTo(MGScreenWidth)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
        }
        self.conversationMessageCollectionView.frame = CGRect.init(x: 0, y: 144, w: MGScreenWidth, h: MGScreenHeight - 64 - 80 - 44)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
