//
//  BSOrderViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

enum BSOrderType:String {
    case Progress       = "1"
    case Over           = "2"
}
class BSOrderViewController: BSBaseTableViewController {
    var orderType:BSOrderType = .Progress
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellId_register("BSOrderOverTableViewCell")
        tableView.cellId_register("BSOrderingCell")
        self.cofigMjHeader()
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in
            guard let `self` = self else { return UITableViewCell() }
            switch self.orderType{
            case .Progress:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSOrderingCell", for: indexPath) as! BSOrderingCell
                return cell
            case .Over:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSOrderOverTableViewCell", for: indexPath) as! BSOrderOverTableViewCell
                return cell
            }
            
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
                switch self.orderType {
                    case .Progress:
                        self.toProgressRCVC()
                        break
                    case .Over:
                        self.toOverRCVC()
                        break
                }
            }.addDisposableTo(rx_disposeBag)
        dataArr.value = [SectionModel.init(model: "one", items: ["1","2","2","2","2","2","2"])]
        
    }
    func toProgressRCVC() {
        let min_num = "1000"
        let max_num = "2000"
        let price   = "36796.43"
        let currency_code = "CNY"
        let quota   = min_num  + "-" + max_num
        let quota_str = "限额：" + quota + currency_code
        
        VCRouter.toRCCloudVC(targetId: "1",
                             title: self.title ?? "",
                             buyInfoModel: BSBuyInfoModel.init(price:price,
                                                               quota:quota_str,
                                                               type:"进行中"))
    }
    func toOverRCVC() {
        let min_num = "1000"
        let max_num = "2000"
        let price   = "36796.43"
        let currency_code = "USD"
        let quota   = min_num  + "-" + max_num
        let quota_str = "限额：" + quota + currency_code
        
        VCRouter.toRCCloudVC(targetId: "1",
                             title: self.title ?? "",
                             buyInfoModel: BSBuyInfoModel.init(price:price,
                                                               quota:quota_str,
                                                               type:"已结束"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
