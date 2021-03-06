//
//  BSOneViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSPurseType {
    case getBTC
    case postBTC
}
class BSPurseViewController: BSBaseTableViewController {
    
    var purseType:BSPurseType = .getBTC
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "钱包"
    }
    override func setUI() {
        super.setUI()

        tableView.cellId_register("BSPurseHeaderCell")
        tableView.cellId_register("BSBTCTypeTableViewCell")
        tableView.cellId_register("BSGetBTCCell")
        tableView.cellId_register("BSPostBTCCell")
        makeCustomerNavigationItem("交易明细", left: false) {
            VCRouter.toTradingDetailVC()
        }
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in
                        guard let `self` = self else { return  UITableViewCell() }
            let section = indexPath.section
            let row = indexPath.row
            switch section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSPurseHeaderCell", for: indexPath) as! BSPurseHeaderCell
                return cell
            case 1:
                if row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BSBTCTypeTableViewCell", for: indexPath) as! BSBTCTypeTableViewCell
                    
                    cell.btnGetBtc.addAction {
                        self.purseType = .getBTC
                        self.tableView.reloadData()
                    }
                    cell.btnPostBtn.addAction {
                        self.purseType = .postBTC
                        self.tableView.reloadData()
                    }
                    cell.purseType = self.purseType
                    return cell
                }else{
                    switch self.purseType{
                    case .getBTC:
                            let cell = tableView.dequeueReusableCell(withIdentifier: "BSGetBTCCell", for: indexPath) as! BSGetBTCCell
                           
                            return cell
                    case .postBTC:
                            let cell = tableView.dequeueReusableCell(withIdentifier: "BSPostBTCCell", for: indexPath) as! BSPostBTCCell
//                            cell.purseType = self.purseType
                            return cell
                    }

                }

                
            default:
                return UITableViewCell()
            }
 
        }
        
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            

        }.addDisposableTo(rx_disposeBag)
        
        
        dataArr.value.append(SectionModel.init(model: "one", items: [BSMeIcon.init(icon: "", title: "")]))
        
        dataArr.value.append(SectionModel.init(model: "two",
                                               items: [BSMeIcon.init(icon: "me_suggest", title: "建议反馈"),
                                                                     BSMeIcon.init(icon: "me_about", title: "关于我们")]))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension BSPurseViewController {
    
   override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
}
