//
//  BSMobileListController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSCountryType {
    case Country   // "国家／地区"
    case Corrency  // 货币
}
class BSMobileListController: BSBaseTableViewController {
    var vc_type:BSCountryType = .Country
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch vc_type {
            case .Country:
             self.title = "国家／地区"
                break
            case .Corrency:
             self.title = "货币选择"
                break
        }
        
        self.title = "国家／地区"
        tableView.cellId_register("BSDigtitalCell")
        
        
        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            
            let  cell = BSDigtitalCell.init(style: .default, reuseIdentifier: "BSDigtitalCell")
            cell.lbTitle.text = (element as? BSMobileListModel)?.name ?? ""
            return cell
            
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
            //            VCRouter.toBuyCoinVC()
            }.addDisposableTo(rx_disposeBag)
        
        request()


    }
    override func request() {
        super.request()
        switch vc_type {
        case .Country:
            BSMobileListViewModel.requestMobileListData("4").subscribe(onNext: {[weak self] (arr) in
                if let strongSelf = self {
                    strongSelf.dataArr.value.append(SectionModel.init(model: "section", items: arr))
                    
                }
                
            }).addDisposableTo(rx_disposeBag)
            break
        case .Corrency:
            
            BSMobileListViewModel.requestCurrencyListData("4").subscribe(onNext: {[weak self] (arr) in
                if let strongSelf = self {
                    strongSelf.dataArr.value.append(SectionModel.init(model: "section", items: arr))
                    
                }
                
            }).addDisposableTo(rx_disposeBag)
            break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    



}
