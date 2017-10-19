//
//  BSMyBuyController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

enum BSMyType {
    case MyADProgress           // 我的广告-进行中
    case MyADOver               // 我的广告-已下架
    case MyBuyProgress          // 我购买的-进行中
    case MyBuyOver              // 我购买的-已结束
    case MySoldProgress         // 我出售的-进行中
    case MySoldOver             // 我出售的-已结束
}

class BSMyBuyController: BSBaseTableViewController {
   let dataSourceOne  = RxTableViewSectionedReloadDataSource<SectionModel<String,BSMyBuyModel>>()
    
    var myType : BSMyType = .MyADProgress

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func setUI() {
        super.setUI()
        tableView.cellId_register("BSMyBuyCell")
        
        dataSourceOne.configureCell = {[weak self](_ , tableView , indexPath , element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BSMyBuyCell", for: indexPath) as! BSMyBuyCell
            cell.myBuyModel = element
            return cell
            
        }

        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
            
        }.addDisposableTo(rx_disposeBag)
        request()
        
    }
    override func request() {
        super.request()
        // 请求我的广告接口
        switch myType {
        case .MyADProgress:
            BSMyADViewModel.requestMyADListData("1", member_id: "13")
                .bind(to: tableView.rx.items(dataSource: dataSourceOne))
                .addDisposableTo(rx_disposeBag)
            break
        case .MyADOver:
            BSMyADViewModel.requestMyADListData("2", member_id: "13")
                .bind(to: tableView.rx.items(dataSource: dataSourceOne))
                .addDisposableTo(rx_disposeBag)
            break
        case .MyBuyProgress:
            BSMyADViewModel.requestMyBuyListData("1", member_id: "13")
                .bind(to: tableView.rx.items(dataSource: dataSourceOne))
                .addDisposableTo(rx_disposeBag)
            break
        case .MyBuyOver:
            BSMyADViewModel.requestMyBuyListData("2", member_id: "13")
                .bind(to: tableView.rx.items(dataSource: dataSourceOne))
                .addDisposableTo(rx_disposeBag)
            break
        case .MySoldProgress:
            break
        case .MySoldOver:
            break
        }

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
extension BSMyBuyController{
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
}
