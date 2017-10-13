//
//  BSMyViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//
import UIKit
struct BSMeIcon {
    let icon : String
    let title : String
}
class BSMyViewController: BSBaseTableViewController {
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
        self.title = "我的"
        setUI()
        configTable()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func configTable(){

        tableView.cellId_register("BSMyTableViewCell")
        tableView.cellId_register("BAMySetTableViewCell")
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = BSCellLineColor
        
        self.navigationController?.navigationBar.shadowImage = UIImage.getImageWithColor(color: BSNavColor)
        
        makeCustomerImageNavigationItem("me_setting", left: false) {
            VCRouter.toSettingVC()
        }
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in
//            guard let `self` = self else { return  UITableViewCell() }
            
            if indexPath.section == 0 && indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSMyTableViewCell", for: indexPath) as! BSMyTableViewCell
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BAMySetTableViewCell", for: indexPath) as! BAMySetTableViewCell
                cell.iconModel = element as! BSMeIcon
                return cell
            }
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in

            let row         = indexpath.element?.row
            let section     = indexpath.element?.section
            
            switch section ?? 0 {
                case 0:
                    switch row ?? 0{
                    case 1:   VCRouter.toADVC(.Adverted)
                    default:
                        break
                }
                case 1:
                    switch row ?? 0{
                    case 0: VCRouter.toSuggestVC()
                    case 1: VCRouter.toAboutMeVC()
                    case 2: VCRouter.toCenterVC()
                    case 3: self.exitLogin()
                    default:
                        break
                }
                case 2:
                    switch row ?? 0{
                    case 0: VCRouter.toSettingVC()

                    default:
                        break
                }
                default:break
                
            }

            }.addDisposableTo(rx_disposeBag)
        
        
        dataArr.value.append(SectionModel.init(model: "one", items: [BSMeIcon.init(icon: "", title: ""),
                                                                     BSMeIcon.init(icon: "me_ad", title: "我的广告"),
                                                                     BSMeIcon.init(icon: "me_friend", title: "邀请好友")]))
        
        dataArr.value.append(SectionModel.init(model: "two", items: [BSMeIcon.init(icon: "me_suggest", title: "建议反馈"),
                                                                     BSMeIcon.init(icon: "me_about", title: "关于我们"),
                                                                     BSMeIcon.init(icon: "me_center", title: "客服中心"),
                                                                     BSMeIcon.init(icon: "me_out", title: "退出登录")]))
    
        
    }
    func exitLogin() {
        let alertController: UIAlertController = UIAlertController(title: "退出登录", message: "你确定要退出登录吗", preferredStyle: .alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style:.cancel, handler: nil)
        alertController.addAction(cancelAction)
        let sureAction: UIAlertAction = UIAlertAction(title: "确定", style: .default) { action -> Void in
            print("退出登录")
        }
        alertController.addAction(sureAction)
        self.present(alertController, animated: true, completion: nil)
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

