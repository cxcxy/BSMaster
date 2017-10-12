//
//  BSPostInputCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
class BSPostInputCell: BSBaseTableViewCell {

    @IBOutlet weak var inputTextView: KMPlaceholderTextView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
