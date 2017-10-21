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
extension UITableView {
   
    
}
class BSMyBuyController: BSBaseTableViewController {
   let dataSourceOne  = RxTableViewSectionedReloadDataSource<SectionModel<String,BSMyBuyModel>>()
    
    var myType : BSMyType = .MyADProgress
    var viewModel  = BSMyADViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func setUI() {
        super.setUI()
        tableView.cellId_register("BSMyBuyCell")
        self.cofigMjHeader()
        dataSourceOne.configureCell = {[weak self](_ , tableView , indexPath , element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BSMyBuyCell", for: indexPath) as! BSMyBuyCell
            cell.myBuyModel = element
            cell.block = { [weak self](is_del,id) in
                guard let `self` = self else { return  }
                self.requestLower(AD_id: id.toString)
            }
            return cell
            
        }

        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
            
        }.addDisposableTo(rx_disposeBag)
        request()
        
    }
    override func request() {
        super.request()
//        tableView.dataSource = nil
//        tableView.rx
//            .setDelegate(self)
//            .addDisposableTo(rx_disposeBag)
        // 请求我的广告接口
        switch myType {
        case .MyADProgress:
//            viewModel.requestMyADListData("1", member_id: "13")
//                .bind(to: tableView.rx.items(dataSource: dataSourceOne))
//                .addDisposableTo(rx_disposeBag)
            break
        case .MyADOver:
//            viewModel.requestMyADListData("2", member_id: "13")
//                .bind(to: tableView.rx.items(dataSource: dataSourceOne))
//                .addDisposableTo(rx_disposeBag)
            break
        case .MyBuyProgress:
            viewModel.requestMyBuyListData("1", member_id: "13")
                .bind(to: tableView.rx.items(dataSource: dataSourceOne))
                .addDisposableTo(rx_disposeBag)
            break
        case .MyBuyOver:
            viewModel.requestMyBuyListData("2", member_id: "13")
                .bind(to: tableView.rx.items(dataSource: dataSourceOne))
                .addDisposableTo(rx_disposeBag)
            break
        case .MySoldProgress:
            break
        case .MySoldOver:
            break
        }
        
        viewModel.refresh.asObservable().subscribe(onNext: {[weak self] (status) in
             guard let `self` = self else { return  }
            self.refreshStatus(status: status)
        }).addDisposableTo(rx_disposeBag)
        
    }
    //MARK: 下架操作
    func requestLower(_ id_del:String = "2",AD_id:String) {
        
        viewModel.requestLowerMyADListData(id_del, AD_id: AD_id).subscribe(onNext: { [weak self](message) in
            guard let `self` = self else { return  }
            BSHud.showMsg(message)
            BSDelay.start(delay: 1.0, closure: {
                self.request()
            })
            
        }).addDisposableTo(rx_disposeBag)
        
//        BSMyADViewModel.requestLowerMyADListData(id_del, AD_id: AD_id).observeOn(MainScheduler.instance).map
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
