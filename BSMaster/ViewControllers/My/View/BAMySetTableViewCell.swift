//
//  BAMySetTableViewCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/30.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BAMySetTableViewCell: BSBaseTableViewCell {
    var iconModel : BSMeIcon! {
        didSet{
            imgIcon.image = UIImage.init(named: iconModel.icon)
            lbTitle.text  = iconModel.title
        }
    }
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
