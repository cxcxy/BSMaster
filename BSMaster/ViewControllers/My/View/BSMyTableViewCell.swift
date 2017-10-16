//
//  BSMyTableViewCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/30.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSMyTableViewCell: BSBaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buyAction(_ sender: Any) {
        VCRouter.toADVC(.Buy)
    }
    
    @IBAction func seleAction(_ sender: Any) {
        VCRouter.toADVC(.Sold)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
