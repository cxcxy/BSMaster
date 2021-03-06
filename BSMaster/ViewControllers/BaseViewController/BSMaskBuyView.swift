//
//  BSMaskBuyView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
typealias BSPostActionBlock = (_ isBuy:Bool) -> ()
class BSMaskBuyView: UIView {
    var clickBlock : BSPostActionBlock?

    @IBAction func postBuyAction(_ sender: Any) {

        if let clickBlock = clickBlock {
            clickBlock(true)
        }
    }
    
    @IBAction func postSaleAction(_ sender: Any) {

        if let clickBlock = clickBlock {
            clickBlock(false)
        }
    }
}
