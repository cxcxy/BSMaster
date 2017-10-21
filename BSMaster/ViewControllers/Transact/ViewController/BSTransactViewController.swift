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
    var viewModel  =  BSPostListViewModel()
    var params:[String: Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

      
        // 接收国家区域变动通知：
        _ = NotificationCenter.default.rx.notification(Notification.Name(Noti_ChooseCountry)).takeUntil(self.rx.deallocated).subscribe(onNext: {[unowned self] (value) in
            print(value)
            
            let dic = value.object as? NSDictionary
            self.params["country_id"]   = dic?["id"]
            self.request()

        })

        // 接收选择货币变动通知：
        _ = NotificationCenter.default.rx.notification(Notification.Name(Noti_ChangeCoinType)).takeUntil(self.rx.deallocated).subscribe(onNext: {[unowned self] (value) in
            print(value)
            
            let dic = value.object as? NSDictionary
            self.params["coin_type"]   = dic?["coin_type"]
            self.request()
            
        })
        
        tableView.cellId_register("BSTransactCell")
        self.cofigMjHeader()
        self.cofigMjFooter()
        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BSTransactCell", for: indexPath) as! BSTransactCell
            cell.transactModel = element as? BSPostListModel
            return cell
            
        }
        
        viewModel.refresh.asObservable().subscribe(onNext: {[weak self] (status) in
            guard let `self` = self else { return  }
            self.refreshStatus(status: status)
        }).addDisposableTo(rx_disposeBag)
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
 
        tableView.rx
            .modelSelected(BSPostListModel.self)
            .subscribe(onNext:  {[unowned self] value in
                if let id = value.id?.toString {
                    VCRouter.toBuyCoinVC(id,transactType:self.transactType)
                }
            })
            .disposed(by: rx_disposeBag)
        
        request()
    }
    override func request() {
        super.request()
        params["type"] = transactType.rawValue
        params["page"]      = pageIndex
        params["page_size"] = 5
        
        viewModel.requestBuyListData(params).subscribe(onNext: { [weak self] (message) in
             guard let `self` = self else { return  }

                self.endRefresh()
                if self.pageIndex == 1{// ＝1 说明操作的下拉刷新 清空数据
                   self.mj_footer.isHidden = false
                    self.dataArr.value.removeAll()
                }
                
                message.enumerated().forEach({
                    self.dataArr.value.append(SectionModel.init(model: String($0), items: [$1]))
                })

            
        }).addDisposableTo(rx_disposeBag)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
