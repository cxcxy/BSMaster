//
//  BSTransactViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

enum BSTransactType:String {
    case Buy    = "2"
    case Sold   = "1"
}

class BSTransactViewController: BSBaseTableViewController {

    var transactType:BSTransactType = .Buy
    var params:[String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "交易"
      
        // 接收通知：
        _ = NotificationCenter.default.rx.notification(Notification.Name("kNotificationCountryName")).takeUntil(self.rx.deallocated).subscribe(onNext: {[unowned self] (value) in
            print(value)
            
            let dic = value.object as? NSDictionary
            self.params["country_id"]   = dic?["id"]
            self.request()

        })


        
        tableView.cellId_register("BSTransactCell")
        self.cofigMjHeader()
        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BSTransactCell", for: indexPath) as! BSTransactCell
            cell.transactModel = element as? BSPostListModel
            return cell
            
        }
      
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
 
        
//        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
//            VCRouter.toBuyCoinVC("1")
//        }.addDisposableTo(rx_disposeBag)
//        tableView.rx.modelSelected(<#T##modelType: T.Type##T.Type#>)
        tableView.rx
            .modelSelected(BSPostListModel.self)
            .subscribe(onNext:  { value in
//                DefaultWireframe.presentAlert("Tapped `\(value)`")
                if let id = value.id?.toString {
                    VCRouter.toBuyCoinVC(id)
                }
                
            })
            .disposed(by: rx_disposeBag)
        
        request()
    }
    override func request() {
        super.request()
        params["type"] = transactType.rawValue

        BSPostListViewModel.requestBuyListData(params).subscribe(onNext: { [unowned self] (message) in
            self.endRefresh()
            self.dataArr.value.removeAll()
            self.dataArr.value.append(SectionModel.init(model: "section", items: message))
        }).addDisposableTo(rx_disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
