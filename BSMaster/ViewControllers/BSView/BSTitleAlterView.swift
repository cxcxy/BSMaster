//
//  BSTitleAlterView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/19.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSTitleAlterView: ETPopupView {
    @IBOutlet weak var lbDes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        animationDuration = 0.3
        type = .alert
        self.snp.makeConstraints { (make) in
            make.width.equalTo(MGScreenWidth - 120)
        }
        ETPopupWindow.sharedWindow().touchWildToHide = true
        self.setCornerRadius(radius: 10.0)
    }

}
