//
//  BSBaseTableViewCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/10.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
