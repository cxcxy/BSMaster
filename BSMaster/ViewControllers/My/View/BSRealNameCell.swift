//
//  BSRealNameCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSRealNameCell: UITableViewCell {

    @IBOutlet weak var lbDes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbDes.text = "为确保交易安全，保障您的合法权益，请您完成身份验证！\n  我们提供安全高效的实时联网官方身份认证服务，具有更高级别的安全保护，身份验证一旦成功，不予修改和接触认证。建议您谨慎选择，真实填写。"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
