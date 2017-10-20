//
//  BSTransactDetailViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSTransactDetailViewController: BSBaseViewController {
    
    var transactType:BSTransactType = .Buy
    
    @IBOutlet weak var btnSold: UIButton!
    
    @IBOutlet weak var btnContact: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var transactDetailModel: BSTransactDetailModel?
    
    var transactId:String!  // 当前 广告ID
    var createOrderModel  = BSCreateOrderModel() // 创建订单请求数据模型
    let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String,Any>>()
    var dataArr =  Variable<[SectionModel<String,Any>]>([])
    override func viewDidLoad() {
        super.viewDidLoad()
        switch transactType {
        case .Buy:
             self.title = "购买比特币"
             btnSold.setTitle("购买", for: UIControlState())
             break
        case .Sold:
             self.title = "出售比特币"
             btnSold.setTitle("出售", for: UIControlState())
             break
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
        tableView.cellId_register("BSBuyCoinCell")
        tableView.cellId_register("BSBuyRemindCell")
        
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in
            guard let `self` = self else { return UITableViewCell() }
            let section         = indexPath.section
            if section == 0 {
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSBuyCoinCell", for: indexPath) as! BSBuyCoinCell
                cell.modelData = (element as! BSTransactDetailModel)
                cell.createOrderModel = self.createOrderModel
                cell.transactType = self.transactType
                return cell
            }else {

                let cell = tableView.dequeueReusableCell(withIdentifier: "BSBuyRemindCell", for: indexPath) as! BSBuyRemindCell
                return cell
            }
            
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(rx_disposeBag)
    
        request()
    }
    override func request() {
        super.request()
        BSTransactDetailViewModel.requestTransactDetailData(self.transactId).subscribe(onNext: {[weak self] (model) in
            guard let `self` = self else { return  }
            self.transactDetailModel = model
            self.dataArr.value.append(SectionModel.init(model: "section", items: [model]))
            self.dataArr.value.append(SectionModel.init(model: "two", items: [model]))
        }).addDisposableTo(rx_disposeBag)
    }
    @IBAction func soldAction(_ sender: Any) {
        createOrderModel.product_id = self.transactId
        
        
        
//        BSTransactDetailViewModel.requestCreateOrderData(self.transactId, price: "1010", coin_num: "1", member_id: "13").subscribe(onNext: { (message) in
//            BSHud.showMsg(message)
//        }).addDisposableTo(rx_disposeBag)
        
        
        let min_num = transactDetailModel?.min_num?.toString ?? ""
        let max_num = transactDetailModel?.max_num?.toString ?? ""
        let price   = transactDetailModel?.price ?? ""
        let currency_code = transactDetailModel?.currency_code ?? ""
        let quota   = min_num  + "-" + max_num
        let quota_str = "限额：" + quota + currency_code
        
        VCRouter.toRCCloudVC(.Buy,targetId: "1",
                             title: self.title ?? "",
                             buyInfoModel: BSBuyInfoModel.init(price:price,
                                                               quota:quota_str,
                                                               type:(btnSold.titleLabel?.text)!))
        
        
    }
    //MARK: 跳转聊天界面
    @IBAction func contactAction(_ sender: Any) {
    
        let min_num = transactDetailModel?.min_num?.toString ?? ""
        let max_num = transactDetailModel?.max_num?.toString ?? ""
        let price   = transactDetailModel?.price ?? ""
        let currency_code = transactDetailModel?.currency_code ?? ""
        let quota   = min_num  + "-" + max_num
        let quota_str = "限额：" + quota + currency_code

        VCRouter.toRCCloudVC(targetId: "1",
                             title: self.title ?? "",
                             buyInfoModel: BSBuyInfoModel.init(price:price,
                                                               quota:quota_str,
                                                               type:(btnSold.titleLabel?.text)!))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
extension BSTransactDetailViewController:UITableViewDelegate {
    
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
