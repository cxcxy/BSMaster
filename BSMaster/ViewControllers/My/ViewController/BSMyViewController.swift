//
//  BSMyViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//
import UIKit

class BSMyViewController: BSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        setUI()
        configTable()
        
    }
    func configTable(){
        tableView.delegate      = nil
        tableView.dataSource    = nil
        tableView.cellId_register("BSMyTableViewCell")
        tableView.cellId_register("BAMySetTableViewCell")
        
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in
//            guard let `self` = self else { return  UITableViewCell() }
            
            if indexPath.section == 0 && indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSMyTableViewCell", for: indexPath) as! BSMyTableViewCell
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BAMySetTableViewCell", for: indexPath) as! BAMySetTableViewCell
                return cell
            }
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
        
        dataArr.value.append(SectionModel.init(model: "one", items: [1,2,3]))
        dataArr.value.append(SectionModel.init(model: "two", items: [1,2]))
        dataArr.value.append(SectionModel.init(model: "Three", items: [1,2,3,4]))
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension BSMyViewController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

