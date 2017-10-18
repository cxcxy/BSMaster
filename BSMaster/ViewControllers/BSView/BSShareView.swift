//
//  BSShareView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/18.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSShareView: ETPopupView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        animationDuration = 0.3
        type = .sheet
        self.snp.makeConstraints { (make) in
            make.width.equalTo(MGScreenWidth)
            make.height.equalTo(110)
        }
        ETPopupWindow.sharedWindow().touchWildToHide = true

    }
    
    @IBAction func wechatAction(_ sender: Any) {
        BSShareManager.share_WechatImg(url: "https://www.baidu.com/", shareImage: "https://www.baidu.com/", successClosure: {
            print("分享朋友圈成功")
        }) { (e) in
            print("分享朋友圈错误")
        }
        
    }
    

    @IBAction func friendsAction(_ sender: Any) {
        BSShareManager.share_WechatFriendsImg(url: "https://www.baidu.com/", shareImage: "https://www.baidu.com/", successClosure: {
            print("分享朋友圈成功")
        }) { (e) in
            print("分享朋友圈错误")
        }
    }
}
