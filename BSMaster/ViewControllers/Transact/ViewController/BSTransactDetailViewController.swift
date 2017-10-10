//
//  BSTransactDetailViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSTransactDetailViewController: BSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate      = nil
        tableView.dataSource    = nil
        tableView.cellId_register("BSBuyCoinCell")
        tableView.cellId_register("BSBuyRemindCell")
        
        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            let section         = indexPath.section
            if section == 0 {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSBuyCoinCell", for: indexPath) as! BSBuyCoinCell
                return cell
            }else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSBuyRemindCell", for: indexPath) as! BSBuyRemindCell
                return cell
            }
            
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
            //             let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSLoginViewController")
            //             let nav = UINavigationController.init(rootViewController: vc)
            //             self.presentVC(nav)
            
            }.addDisposableTo(rx_disposeBag)
        dataArr.value.append(SectionModel.init(model: "section", items: ["1"]))
        dataArr.value.append(SectionModel.init(model: "two", items: ["1"]))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
extension BSTransactDetailViewController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
