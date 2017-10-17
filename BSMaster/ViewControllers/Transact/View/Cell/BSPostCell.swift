//
//  BSPostCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSPostInputType {
    
    case Locus              // 所在地
    case Currency           // 货币
    case numberCurrency     // 数字货币
    case overFlow           // 溢价
    case price              // 价格
    case min_price          // 最低价
    case min_num            // 最小量
    case max_num            // 最大量
    case payType            // 付款方式
    case payTime            // 付款期限
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
            self.inputType           = model.inputType
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
        case .overFlow:
            postModel.premium_rate  = str
            break
        case .price:
            postModel.price         = str
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
