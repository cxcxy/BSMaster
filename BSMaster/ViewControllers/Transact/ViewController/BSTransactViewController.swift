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

        tableView.cellId_register("BSTransactCell")
        
        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BSTransactCell", for: indexPath) as! BSTransactCell
            return cell
            
        }
      
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
 
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            VCRouter.toBuyCoinVC()
        }.addDisposableTo(rx_disposeBag)
        dataArr.value.append(SectionModel.init(model: "section", items: ["1","1","1","1","1","1","1","1","1","1","1"]))
        request()
    }
    override func request() {
        super.request()
        let params:[String: Any] = ["type":"1"]

        BSPostListViewModel.requestBuyListData(params).subscribe(onNext: { (message) in
            print(message)
        }).addDisposableTo(rx_disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
