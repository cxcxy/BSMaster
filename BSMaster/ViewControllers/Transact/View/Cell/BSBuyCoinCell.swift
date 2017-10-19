//
//  BSBuyCoinCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/10.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSBuyCoinCell: BSBaseTableViewCell {

    @IBOutlet weak var btnInputQuota: UIButton!
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
    @IBOutlet weak var viewPayType: UIView!
    @IBOutlet weak var lbMeaasage: UILabel!
    
    var createOrderModel  : BSCreateOrderModel?
    
    var transactType:BSTransactType = .Buy{
        didSet{
            switch transactType {
            case .Buy:
                 tfBTC.placeholder = "输入买入数量"
            case .Sold:
                 tfBTC.placeholder = "输入卖出数量"
            }
           
        }
    }
    
    var modelData:BSTransactDetailModel?{
        didSet{

            let min_num = modelData?.min_num?.toString ?? ""
            let max_num = modelData?.max_num?.toString ?? ""
            let price   = modelData?.price ?? ""
            let currency_code = modelData?.currency_code ?? ""
            let quota   = min_num  + "-" + max_num
            self.lbQuota.text = "交易限额：" + quota + currency_code
            self.tfCNY.placeholder = quota
            self.lbPrice.text = price + currency_code
            self.lbTranctNumber.text = modelData?.transaction_count?.toString ?? ""
            self.lbName.text = modelData?.nickname ?? ""
            self.lbPaytype.text = modelData?.payment ?? ""
            self.lbMeaasage.text = modelData?.message ?? ""
            let rate            = modelData?.favorable_rate?.toString ?? ""
            self.lbRate.text    = rate + "%"
            let history         = modelData?.historical_transaction?.toString ?? ""
            self.lbHistory.text = history + "BTC"
            let pic = modelData?.favicon
            
            self.btnInputQuota.set_Title("交易限额：" + quota)
            
            self.imgPhoto.set_Img_Url(pic)
 
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewPayType.setCornerRadius(radius: 3.0)
        //判断输入的价钱是否在限额以内
        tfCNY.rx.text.orEmpty.asObservable().filter{ // 过滤空字符串
                    return $0 != ""
            }
            .distinctUntilChanged() // 过滤连续重复的值
            .map{
                let min_num = self.modelData?.min_num ?? 0
                let max_num = self.modelData?.max_num ?? 0
                let inputPrice = $0.toInt()
                
                self.createOrderModel?.price = $0
                
                if let inputPrice = inputPrice {
                  return  inputPrice >= min_num &&  inputPrice <= max_num
                }else{
                    return false
                }
            }
            .bind(to: btnInputQuota.rx.isEnabled) // 绑定到按钮是否可以点击
            .disposed(by: rx_disposeBag)
        
        
        tfBTC.rx.text.orEmpty.subscribe(onNext: { [unowned self](str) in
            self.createOrderModel?.coin_num = str
        }).addDisposableTo(rx_disposeBag)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
