//
//  BSSettingViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/9.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
struct SettingModel {
    var title: String
    var subTitle:String
}
class BSSettingViewController: BSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        configTable()

    }
    func configTable(){
//        tableView.delegate      = nil
//        tableView.dataSource    = nil
        tableView.cellId_register("BSSettingCell")
        
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in

                let cell = tableView.dequeueReusableCell(withIdentifier: "BSSettingCell", for: indexPath) as! BSSettingCell
                cell.lbTitle.text = (element as? SettingModel)?.title
                cell.lbSubTitle.text = (element as? SettingModel)?.subTitle
                return cell

        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
//        tableView.rx
//            .setDelegate(self)
//            .addDisposableTo(rx_disposeBag)
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
            }.addDisposableTo(rx_disposeBag)
        
        let itemsOne = [SettingModel.init(title: "实名认证", subTitle: "未认证"),
                        SettingModel.init(title: "资金密码", subTitle: "已设置")]
        
        let itemsTwo = [SettingModel.init(title: "绑定手机", subTitle: "已绑定"),
                        SettingModel.init(title: "绑定邮箱", subTitle: "未绑定"),
                        SettingModel.init(title: "登录密码", subTitle: "")]
        
        let itemsThree = [SettingModel.init(title: "语言", subTitle: "")]
        
        
        dataArr.value.append(SectionModel.init(model: "one", items: itemsOne))
        dataArr.value.append(SectionModel.init(model: "two", items: itemsTwo))
        dataArr.value.append(SectionModel.init(model: "Three", items: itemsThree))
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension BSSettingViewController {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
