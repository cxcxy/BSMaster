//
//  BSTransactDetailViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSTransactDetailViewController: BSBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String,Any>>()
    var dataArr =  Variable<[SectionModel<String,Any>]>([])
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "出售比特币"
        makeCustomerNavigationItem("帮助", left: false) {
            
        }
        tableView.delegate      = nil
        tableView.dataSource    = nil
        tableView.backgroundColor = tableColor
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
    @IBAction func soldAction(_ sender: Any) {
        
        
    }
    @IBAction func contactAction(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
extension BSTransactDetailViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
