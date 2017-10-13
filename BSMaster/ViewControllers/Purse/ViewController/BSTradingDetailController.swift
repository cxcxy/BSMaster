//
//  BSTradingDetailController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSTradingDetailController: BSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellId_register("BSTradingCell")

        makeCustomerNavigationItem("筛选", left: false) {[unowned self] in
            self.showScrrenView()
        }
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in
            //            guard let `self` = self else { return  UITableViewCell() }

            let cell = tableView.dequeueReusableCell(withIdentifier: "BSTradingCell", for: indexPath) as! BSTradingCell
            return cell
            
        }
        
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
            
        }.addDisposableTo(rx_disposeBag)
        
        dataArr.value.append(SectionModel.init(model: "one", items: [BSMeIcon.init(icon: "", title: "")]))
        
      
    }

    
    func showScrrenView(){
        
        let view = BSScreenView.loadFromNib()
        view.show()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}
