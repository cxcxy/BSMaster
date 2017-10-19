//
//  BSMyBuyCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSMyBuyCell: BSBaseTableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTitlType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbPayType: UILabel!
    @IBOutlet weak var lbTradingLimit: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var btnType: UIButton!
    @IBOutlet weak var viewType: UIView!
    
    var myBuyModel: BSMyBuyModel! {
        didSet{
            lbTitle.text = myBuyModel.type ?? ""
            lbTitlType.text = myBuyModel.is_del ?? ""
            
            lbPayType.text = myBuyModel.payment ?? ""
            let price   = myBuyModel.price ?? ""
            let min_num = myBuyModel.min_num?.toString ?? ""
            let max_num = myBuyModel.max_num?.toString ?? ""
            let currency_code = myBuyModel.currency_code ?? ""
            lbTradingLimit.text = "交易限额：" + min_num  + "-" + max_num + currency_code
            lbPrice.text        = price + currency_code

            lbTime.text = myBuyModel.create_time ?? ""
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        btnType.setCornerRadius(radius: 5.0)
        viewType.setCornerRadius(radius: 2.0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
