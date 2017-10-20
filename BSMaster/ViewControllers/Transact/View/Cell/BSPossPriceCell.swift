//
//  BSPossPriceCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/19.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPossPriceCell: BSBaseTableViewCell {

    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var tfOverFlow: UITextField!
    
   
    var postModel : BSPostModel?
    let price:Double = 37167.35
    override func awakeFromNib() {
        super.awakeFromNib()
        //判断输入的价钱是否在限额以内
        tfOverFlow.rx.text.orEmpty.asObservable()
            .distinctUntilChanged() // 过滤掉连续重复的值
            .map{
                if $0 == "" {
                    return self.price.toString
                }
                if let double = $0.toDouble() {
                    let str         = (self.price * double)/100
                    let price_all   = str + self.price
                    let price_all_str = price_all.toString
                    self.postModel?.price = price_all_str
                    self.postModel?.premium_rate = $0
                    return price_all_str
                }else {
                    return self.lbPrice.text!
                }
            }
            .bind(to: lbPrice.rx.text) // 绑定到按钮是否可以点击
            .disposed(by: rx_disposeBag)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
