//
//  BSTransactViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSTransactViewController: BSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "交易"
        tableView.delegate      = nil
        tableView.dataSource    = nil
        tableView.cellId_register("BSTransactCell")

        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BSTransactCell", for: indexPath) as! BSTransactCell
            return cell
            
        }
      
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
 
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(rx_disposeBag)
        
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            let vc = UIStoryboard.getStoryVC(.Transact, identifier: "BSTransactDetailViewController")
            self.pushVC(vc)
            
        }.addDisposableTo(rx_disposeBag)
        dataArr.value.append(SectionModel.init(model: "section", items: ["1","1","1","1","1","1","1","1","1","1","1"]))
        
    }
    override func request() {
        super.request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
