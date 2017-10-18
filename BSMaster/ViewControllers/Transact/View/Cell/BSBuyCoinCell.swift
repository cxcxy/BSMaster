//
//  BSBuyCoinCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/10.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSBuyCoinCell: BSBaseTableViewCell {

    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPaytype: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbQuota: UILabel!
    @IBOutlet weak var lbTranctNumber: UILabel!
    @IBOutlet weak var lbRate: UILabel!
    @IBOutlet weak var lbHistory: UILabel!
    @IBOutlet weak var tfCNY: UITextField!
    @IBOutlet weak var tfBTC: UITextField!
    
    var modelData:BSTransactDetailModel!{
        didSet{
            self.lbName.text = modelData.nickname ?? ""
            self.lbPaytype.text = BSPayTypeArr[modelData.payment ?? 0]
            self.lbPrice.text = modelData.price ?? ""
            
            let min_num = modelData.min_num?.toString ?? ""
            let max_num = modelData.max_num?.toString ?? ""
            
            self.lbQuota.text = "交易限额：" + min_num  + "-" + max_num + "CNY"
            
            self.lbTranctNumber.text = modelData.transaction_count?.toString ?? ""
            
            self.lbRate.text = modelData.favorable_rate?.toString ?? ""
            
            self.lbHistory.text = modelData.historical_transaction?.toString ?? ""
            let pic = modelData.favicon
            self.imgPhoto.set_Img_Url(pic)
 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
