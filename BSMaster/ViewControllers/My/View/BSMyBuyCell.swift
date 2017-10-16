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
