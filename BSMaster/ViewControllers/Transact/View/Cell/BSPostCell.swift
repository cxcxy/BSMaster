//
//  BSPostCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSPostInputType:String {
    
    case Locus         = "请选择您要发布广告的国家。"     // 所在地
    case Currency      = "您希望交易付款的货币类型。"     // 货币
    case overFlow      = "基于市场价的溢出比例,市场价是根据部分大型交易所实时价格得出的,确保您的报价趋于一个相对合理范围,比如当前价格为7000,溢价比例为10%,那么价格为7700。"     // 溢价
    case price         = "基于溢价比例得到的报价，10分钟更新一次。"     // 价格
    case min_num       = "一次交易的最低的交易限制。"     // 最小量
    case max_num       = "一次交易的最大交易限制，您的钱包余额也会影响最大量的设置。"     // 最大量
    
    case payType        = "您需要指定一种最有效的付款方式，以帮助对方更快的与你达成交易。"       // 付款方式
    case payTime        = "您承诺在此期限内付款。"     // 付款期限
    case numberCurrency = "数字货币"     // 数字货币
    case min_price      = "最低价"    // 最低价

}


class BSPostCell: BSBaseTableViewCell {
    var model : BSPostStyleModel! {
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
            self.inputType           = model.inputType // 输入的类型

            self.lbDes.text          = model.coinType // "%" "CNY" "分钟"

            self.tfContent.isEnabled = model.isInput
        }
    }
    var inputType:BSPostInputType = .Locus
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfContent: UITextField!
    @IBOutlet weak var lbDes: UILabel!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var btnQuestion: UIButton!
    var postModel : BSPostModel?
    var chooseIndex: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnQuestion.addAction {[unowned self] in
            let v = BSTitleAlterView.loadFromNib()
            v.lbDes.text = self.inputType.rawValue
            v.show()
        }
        
        
        tfContent.rx.text.orEmpty.subscribe(onNext: { [unowned self](str) in
            self.updateModelData(str)
        }).addDisposableTo(rx_disposeBag)
        self.contentView.addTapGesture { [weak self](sender) in
            if let strongSelf = self {
                switch strongSelf.inputType {
                    case .payType:
                        VCRouter.prentPirckerMask(dataArr: BSPayTypeArr, startIndex: strongSelf.chooseIndex, block: { (str, index) in
                            strongSelf.chooseIndex = index
                            strongSelf.postModel?.payment = (index + 1).toString
                        
                            strongSelf.tfContent.text = str
                        })
                    case .Locus:
                        VCRouter.toCountryVC( block: { (str, id,code) in
                            print(str,id,code)
                            strongSelf.model.content    = str
                            strongSelf.tfContent.text   = str
                            strongSelf.postModel?.country_id = id.toString
                            strongSelf.postModel?.currency_code = code
                        })
                case .Currency:
                    print("货币")
                    break
                case .numberCurrency:
                    print("数字货币")
                    break
                default:break
                }

            }
        }
    }
    func updateModelData(_ str:String)  {
        guard let postModel = postModel else {
            return
        }
        model.content = str
        switch inputType {
        case .Locus:
            break
        case .Currency:
            break
        case .numberCurrency:
            break
    
        case .min_price:
            postModel.min_price     = str
            break
        case .max_num:
            postModel.max_num       = str
            break
        case .min_num:
            postModel.min_num       = str
            break
        case .payTime:
            postModel.payment_term       = str
            break
        default:break
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
