//
//  BSGetBTCCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSGetBTCCell: BSBaseTableViewCell {

    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var btnCopy: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnCopy.addBorder(width: 0.5, color: MGRgb(22, g: 145, b: 239))
        btnCopy.setCornerRadius(radius: 7.0)
    }

    @IBAction func clickCopyAction(_ sender: Any) {
        //复制
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        [pasteboard setString:self.label.text];
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.lbAddress.text
        BSHud.showMsg("复制成功")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
