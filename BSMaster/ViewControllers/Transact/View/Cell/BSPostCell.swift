//
//  BSPostCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPostCell: BSBaseTableViewCell {
    var model : BSPostModel! {
        didSet{
            self.lbTitle.text            = model.title
            self.imgRight.isHidden       = model.imgRight
            self.lbDes.isHidden          = !self.imgRight.isHidden
            if model.content != "" {
                 self.tfContent.text            = model.content
                 self.tfContent.placeholder     = ""
            }else{
                self.tfContent.text             = ""
                self.tfContent.placeholder      = model.plactHold
            }
            
           
            
        }
    }
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfContent: UITextField!
    @IBOutlet weak var lbDes: UILabel!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var btnQuestion: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
