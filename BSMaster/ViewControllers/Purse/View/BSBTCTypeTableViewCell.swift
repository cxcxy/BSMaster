//
//  BSBTCTypeTableViewCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSBTCTypeTableViewCell: BSBaseTableViewCell {
    var purseType:BSPurseType = .getBTC {
        didSet{
            switch purseType {
            case .getBTC:
                btnGetBtc.isSelected = true
                lbOneLine.isHidden   = false
                btnPostBtn.isSelected = false
                lbTwoLine.isHidden = true
                break
            case .postBTC:
                btnGetBtc.isSelected = false
                lbOneLine.isHidden   = true
                btnPostBtn.isSelected = true
                lbTwoLine.isHidden = false
                break
            }
            
        }
    }
    @IBOutlet weak var btnPostBtn: UIButton!
    @IBOutlet weak var btnGetBtc: UIButton!
    @IBOutlet weak var lbOneLine: UILabel!
    
    @IBOutlet weak var lbTwoLine: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func postAction(_ sender: Any) {
        
    }
    
    @IBAction func getAction(_ sender: Any) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
