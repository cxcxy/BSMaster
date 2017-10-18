//
//  BSRCMessageViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/18.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSRCMessageViewController: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         configUI()
    }
    func configUI()  {
        let v = BSMessageHeaderView.loadFromNib()

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
