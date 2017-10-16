//
//  BSPostViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSPostType {
    case Buy    // 购买
    case Sale   // 出售
}
class BSPostViewController: BSBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String,BSPostModel>>()
    var dataArr =  Variable<[SectionModel<String,BSPostModel>]>([])
    @IBOutlet weak var btnPost: BSNextBtn!
    
    var postType:BSPostType = .Buy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch postType {
        case .Buy:
             self.title = "发布购买广告"
        case .Sale:
             self.title = "发布出售广告"
        }
       
        makeCustomerNavigationItem("帮助", left: false) {
            
        }
        tableView.delegate      = nil
        tableView.dataSource    = nil
        tableView.estimatedRowHeight        =  100
        tableView.rowHeight                 = UITableViewAutomaticDimension
        self.tableView.separatorStyle       = .none
        self.tableView.keyboardDismissMode  = .onDrag
        
        tableView.backgroundColor = tableColor
        tableView.cellId_register("BSPostCell")
        tableView.cellId_register("BSPostInputCell")
        tableView.cellId_register("BSPostHighTableViewCell")
 
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in

//            guard let `self` = self else { return  UITableViewCell() }
            
            let section = indexPath.section
            switch section {
            case 0,1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSPostCell", for: indexPath) as! BSPostCell
                cell.model = element
                if indexPath.section == 1 && indexPath.row == 0 {
                    cell.lbDes.text = "%"
                }
                
                return cell
            case 2:
//                let cell = tableView.dequeueReusableCell(withIdentifier: "BSPostHighTableViewCell", for: indexPath) as! BSPostHighTableViewCell
//
//                return cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSPostInputCell", for: indexPath) as! BSPostInputCell
                cell.inputTextView.placeholder = "广告留言（下单前后都可见）\n请说明有关您交易的相关条款或备注您的支付方式，如微信号，支付宝号等，以便对方可以快速和你交易"
                return cell
            case 3:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSPostHighTableViewCell", for: indexPath) as! BSPostHighTableViewCell
                
                return cell
            default:
                return UITableViewCell()
            }
            

           
            
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
//            VCRouter.
            VCRouter.toTitleListVC(.DigitalCoin)
            //             let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSLoginViewController")
            //             let nav = UINavigationController.init(rootViewController: vc)
            //             self.presentVC(nav)
            
            }.addDisposableTo(rx_disposeBag)
        let ontArray = [BSPostModel.init(title: "所在地", content: "中国", placHold: ""),
                        BSPostModel.init(title: "货币", content: "人民币", placHold: ""),
                        BSPostModel.init(title: "数字货币", content: "比特币（BTC）", placHold: "")]
        
        let twoArray = [BSPostModel.init(title: "溢价", content: "", placHold: "根据市场的溢价比例",imgRight: true),
                        BSPostModel.init(title: "价格", content: "25969.21", placHold: "",imgRight: true),
                        BSPostModel.init(title: "最低价", content: "", placHold: "广告最低可成交的价格",imgRight: true),
                        BSPostModel.init(title: "最小量", content: "", placHold: "每一笔交易额的最小限额",imgRight: true),
                        BSPostModel.init(title: "最大量", content: "", placHold: "每一笔交易额的最大限额",imgRight: true),
                        BSPostModel.init(title: "付款方式", content: "现金存款", placHold: "")]
       
        let sectionArray = [BSPostModel.init(title: "所在地", content: "中国", placHold: "")]
        let fourArray = [BSPostModel.init(title: "所在地", content: "中国", placHold: "")]
        
        
        dataArr.value.append(SectionModel.init(model: "section", items: ontArray))
        dataArr.value.append(SectionModel.init(model: "two", items: twoArray))
        dataArr.value.append(SectionModel.init(model: "three", items: sectionArray))
        dataArr.value.append(SectionModel.init(model: "four", items: fourArray))
    }
    func requestPostBuy()  {
        var params = [String:Any]
        params["type"]  = "1"
        params["coin_type"]  = "1"
        params["member_id"]  = "1"
        params["is_safe"]  = "1"
        params["country_id"]  = "1"
        params["currency_code"]  = "1"
        params["premium_rate"]  = "1"
        params["price"]  = "1"
        params["min_price"]  = "1"
        params["min_num"]  = "1"
        params["max_num"]  = "1"
        params["payment"]  = "1"
        params["message"]  = "1"
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
extension BSPostViewController:UITableViewDelegate {

        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 10
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.01
        }
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return nil
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return nil
        }
    
}
