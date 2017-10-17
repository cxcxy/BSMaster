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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        params["type"]          = "2"
        params["coin_type"]     = "1"
        params["country_id"]    = "44"
        
        viewChooseCountry.addTapGesture { [weak self] (sender) in
            guard let strongSelf = self else { return }
            VCRouter.toCountryVC(block: { (str, id, code) in
                print(str,id,code)
                strongSelf.lbCountry.text = str
                 strongSelf.params["country_id"] = id
            })
        }
        viewChoosePay.addTapGesture { [weak self](sender) in
            guard let strongSelf = self else { return }
            VCRouter.prentPirckerMask(dataArr: BSPayTypeArr, startIndex: strongSelf.chooseIndex, block: { (str, index) in
                strongSelf.chooseIndex = index
                strongSelf.lbPayType.text = str
                strongSelf.params["payment"] = index + 1
            })
        }

        tfMinPrice.rx.text.subscribe(onNext: { [weak self](text) in

             guard let strongSelf = self else { return }
            strongSelf.params["min_price"] = text
            
        }).addDisposableTo(rx_disposeBag)
        
        tfMacPrice.rx.text.subscribe(onNext: { [weak self](text) in

            guard let strongSelf = self else { return }
            strongSelf.params["max_price"] = text
            
        }).addDisposableTo(rx_disposeBag)
        
        btnSearch.rx.tap.subscribe(onNext: { [weak self] in
            guard let strongSelf = self else { return }
            VCRouter.toSearchADResultVC(strongSelf.params)
        }).addDisposableTo(rx_disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
