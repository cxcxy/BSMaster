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
    
    var transactModel :BSPostListModel! {
        didSet{
            self.lbName.text = transactModel.nickname
            self.lbCoinNumer.text = transactModel.price
            self.lbInfo.text = "交易" + (transactModel.transaction_count?.toString)! + "|" +
            "好评" + (transactModel.favorable_rate?.toString)! + "%|" +
            "信任" + (transactModel.trust_count?.toString)!
            self.lbQuota.text = "限额：" + (transactModel.min_num?.toString)! + "-" + (transactModel.max_num?.toString)! + " CNY"
            self.lbPayType.text = BSPayTypeArr[transactModel.payment!]
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        btnBuy.addBorder(width: 1, color: MGRgb(56, g: 161, b: 243))
        btnBuy.setCornerRadius(radius: 5.0)
        viewPayType.setCornerRadius(radius: 3.0)
        viewOnLine.setCornerRadius(radius: 4.5)
        viewOnLine.addBorder(width: 1, color: UIColor.white)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
