//
//  BSTransactCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSTransactCell: BSBaseTableViewCell {

    @IBOutlet weak var imgPhoto: UIImageView! // 头像
    @IBOutlet weak var lbName: UILabel!  // 姓名
    @IBOutlet weak var lbPayType: UILabel! // 支付类型
    
    @IBOutlet weak var viewPayType: UIView!
    @IBOutlet weak var lbCoinNumer: UILabel! // 币的数目
    
    @IBOutlet weak var lbInfo: UILabel! // 个人交易信息
    
    @IBOutlet weak var lbQuota: UILabel! // 额度
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var viewOnLine: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnBuy.addBorder(width: 1, color: MGRgb(56, g: 161, b: 243))
        btnBuy.layer.cornerRadius           = 5.0
        viewPayType.layer.cornerRadius      = 3.0
        viewOnLine.layer.cornerRadius       = 4.5
        viewOnLine.addBorder(width: 1, color: UIColor.white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
