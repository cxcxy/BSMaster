//
//  BSMessageHeaderView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/18.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSMessageHeaderView: UIView {
    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var lbQuate: UILabel!
    @IBOutlet weak var btnSold: UIButton!
    var buyInfoModel : BSBuyInfoModel! {
        didSet{
            
            lbPrice.text = "报价：" + buyInfoModel.price
            lbQuate.text = "限额" + buyInfoModel.quota
            btnSold.set_Title(buyInfoModel.type)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        btnSold.setCornerRadius(radius: 5.0)
    }

}
