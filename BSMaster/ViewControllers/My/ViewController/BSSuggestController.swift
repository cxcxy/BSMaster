//
//  BSSuggestController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSSuggestController: BSBaseTableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "建议反馈"
        tableView.delegate      = nil
        tableView.dataSource    = nil
        tableView.cellId_register("BSSuggestCell")
  
        tableView.backgroundColor = UIColor.white
        dataSource.configureCell = {(_ , tableView , indexPath , element) in

            let cell = tableView.dequeueReusableCell(withIdentifier: "BSSuggestCell", for: indexPath) as! BSSuggestCell
            return cell

        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        dataArr.value.append(SectionModel.init(model: "one", items: [BSMeIcon.init(icon: "", title: "")]))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    



}
