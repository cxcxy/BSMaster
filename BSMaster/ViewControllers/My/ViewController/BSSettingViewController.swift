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

    }
    override func setUI() {
        super.setUI()
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
        
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
            self.toVC(indexpath.element)
            
            }.addDisposableTo(rx_disposeBag)
        
        let itemsOne = [SettingModel.init(title: "实名认证", subTitle: "未认证"),
                        SettingModel.init(title: "资金密码", subTitle: "已设置")]
        
        let itemsTwo = [SettingModel.init(title: "登录密码", subTitle: "")]
        
        let itemsThree = [SettingModel.init(title: "语言", subTitle: "")]
        
        
        dataArr.value.append(SectionModel.init(model: "one", items: itemsOne))
        dataArr.value.append(SectionModel.init(model: "two", items: itemsTwo))
        dataArr.value.append(SectionModel.init(model: "Three", items: itemsThree))
    }

    func toVC(_ indexPath: IndexPath?) {
        guard let index = indexPath else {
            return
        }
        let section = index.section
        let row = index.row
        switch section {
        case 0:
            if row == 0 {
                 VCRouter.toRealNameVC()
            }else{
                
                if true {// 在这判断用户是否已经设置过密码  ,跳转使用原密码更改密码逻辑
                    VCRouter.toInputMoneyPassVC(.MoneyOldPassWord)
                }else{
                    VCRouter.toInputMoneyPassVC(.MoneyPassWord)
                }
                
            }
            break
        case 1:
            if true {// 在这判断用户是否已经设置过密码  ,跳转使用原密码更改密码逻辑
                VCRouter.toInputMoneyPassVC(.LoginOldPassWord)
            }else{
                VCRouter.toInputMoneyPassVC(.LoginPassWord)
            }
   
            break
        case 2:
               VCRouter.toTitleListVC(.Language)
        default: break
            
        }
       

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
