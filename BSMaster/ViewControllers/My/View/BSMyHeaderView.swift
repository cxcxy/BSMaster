//
//  BSMyHeaderView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/20.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSMyHeaderView: UIView {

    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgPhoto: UIImageView!

    @IBAction func buyAction(_ sender: Any) {
        VCRouter.toADVC(.Buy)
    }
    
    @IBAction func seleAction(_ sender: Any) {
        VCRouter.toADVC(.Sold)
    }
}
