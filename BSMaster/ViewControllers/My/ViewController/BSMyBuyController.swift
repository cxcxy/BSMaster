//
//  BSMyBuyController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSMyBuyController: BSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func setUI() {
        super.setUI()
        tableView.cellId_register("BSMyBuyCell")
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BSMyBuyCell", for: indexPath) as! BSMyBuyCell

            return cell
            
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
            
        }.addDisposableTo(rx_disposeBag)
        
        let arr  = [1,2,3,4,5,6]
        
        for i in arr {
            dataArr.value.append(SectionModel.init(model: i.toString, items: [i]))
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
