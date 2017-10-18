//
//  BSSearchController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSSearchController: BSBaseViewController {

    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var btnSearch: BSNextBtn!
    @IBOutlet weak var viewChooseMoney: UIView!
    @IBOutlet weak var viewChoosePay: UIView!
    @IBOutlet weak var tfMacPrice: UITextField!
    @IBOutlet weak var tfMinPrice: UITextField!
    @IBOutlet weak var viewChooseCountry: UIView!
      var chooseIndex: Int = 0
    @IBOutlet weak var lbCoinType: UILabel!
    @IBOutlet weak var lbPayType: UILabel!
    var params:[String:Any] = [:]
    
    var post_paramsModel : BSSearchModel = BSSearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 默认值 。 购买， 比特币， 中国
        post_paramsModel.type       = "2"
        post_paramsModel.coin_type  = "1"
        post_paramsModel.country_id = "44"

        
        viewChooseCountry.addTapGesture { [weak self] (sender) in
            guard let strongSelf = self else { return }
            VCRouter.toCountryVC(block: { (str, id, code) in
                print(str,id,code)
                strongSelf.lbCountry.text = str
                 strongSelf.post_paramsModel.country_id = id.toString

            })
        }
        viewChoosePay.addTapGesture { [weak self](sender) in
            guard let strongSelf = self else { return }
            VCRouter.prentPirckerMask(dataArr: BSPayTypeArr, startIndex: strongSelf.chooseIndex, block: { (str, index) in
                strongSelf.chooseIndex = index
                strongSelf.lbPayType.text = str
//                strongSelf.params["payment"] = index + 1
                strongSelf.post_paramsModel.payment = (index + 1).toString
            })
        }

        tfMinPrice.rx.text.orEmpty.subscribe(onNext: { [weak self](text) in

             guard let strongSelf = self else { return }
            
            strongSelf.post_paramsModel.min_price = text
            
        }).addDisposableTo(rx_disposeBag)
        
        tfMacPrice.rx.text.orEmpty.subscribe(onNext: { [weak self](text) in

            guard let strongSelf = self else { return }
//            strongSelf.params["max_price"] = text
            strongSelf.post_paramsModel.max_price = text
            
        }).addDisposableTo(rx_disposeBag)
        
        btnSearch.rx.tap.subscribe(onNext: { [weak self] in
            guard let strongSelf = self else { return }
            VCRouter.toSearchADResultVC(strongSelf.post_paramsModel.toJSON())
        }).addDisposableTo(rx_disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
