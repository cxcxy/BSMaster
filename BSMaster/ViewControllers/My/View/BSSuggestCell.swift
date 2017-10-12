//
//  BSSuggestCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
class BSSuggestCell: BSBaseTableViewCell {
    @IBOutlet weak var tfSuggest: KMPlaceholderTextView!
    @IBOutlet weak var btnCommit: UIButton!
    @IBOutlet weak var tfWeChat: UITextField!
    @IBOutlet weak var tfEmali: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnCommit.layer.cornerRadius = 7.0
        btnCommit.addBorder(width: 0.5, color: MGRgb(196, g: 199, b: 206))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
