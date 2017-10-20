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
    let dataSource  = RxTableViewSectionedReloadDataSource<SectionModel<String,BSPostStyleModel>>()
    var dataArr =  Variable<[SectionModel<String,BSPostStyleModel>]>([])
    @IBOutlet weak var btnPost: BSNextBtn!
    
    var postType:BSPostType = .Buy
    var postModel = BSPostModel()
    

    
    var price_str: Variable<String>? = nil
    
    var oneArray:[BSPostStyleModel] = []
    var twoArray:[BSPostStyleModel] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch postType {
        case .Buy:
             self.title = "发布购买广告"
             postModel.type = "2"
        case .Sale:
             self.title = "发布出售广告"
             postModel.type = "1"
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
        tableView.cellId_register("BSPossPriceCell")
        
 
        dataSource.configureCell = {[weak self](_ , tableView , indexPath , element) in

            guard let `self` = self else { return  UITableViewCell() }
            
            let section = indexPath.section
            switch section {
            case 0,1:
              
                if indexPath.section == 1 && indexPath.row == 0 {
                   
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BSPossPriceCell", for: indexPath) as! BSPossPriceCell
                      cell.postModel = self.postModel
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "BSPostCell", for: indexPath) as! BSPostCell
                    cell.model = element
                    cell.postModel = self.postModel
                     return cell
                }
                

               
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSPostInputCell", for: indexPath) as! BSPostInputCell
                cell.inputTextView.placeholder = "广告留言（下单前后都可见）\n请说明有关您交易的相关条款或备注您的支付方式，如微信号，支付宝号等，以便对方可以快速和你交易"
                cell.postModel = self.postModel
                return cell
            case 3:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSPostHighTableViewCell", for: indexPath) as! BSPostHighTableViewCell
                cell.postModel = self.postModel
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

            self.toVC(indexpath.element)

            }.addDisposableTo(rx_disposeBag)
        
        // 发布按钮
        btnPost.rx.tap.subscribe(onNext: {[weak self] in
            guard let `self` = self else { return  }
            self.requestPostBuy()
            
        }).addDisposableTo(rx_disposeBag)

        self.configOneArrayData()
        self.configTwoArrayData()

        let sectionArray = [BSPostStyleModel.init(title: "所在地", content: "中国",  placHold: "")]
        let fourArray = [BSPostStyleModel.init(title: "所在地", content: "中国", placHold: "")]
        
        dataArr.value.append(SectionModel.init(model: "three", items: sectionArray))
        dataArr.value.append(SectionModel.init(model: "four", items: fourArray))

    
    }
    func configOneArrayData()  {
        oneArray = [BSPostStyleModel.init(title: "所在地", content: "中国", placHold: "",inputType:.Locus,isInput:false),
                    BSPostStyleModel.init(title: "货币", content: "人民币", placHold: "",inputType:.Currency,isInput:false),
                    BSPostStyleModel.init(title: "数字货币", content: "比特币（BTC）", placHold: "",inputType:.numberCurrency,isInput:false)]
        dataArr.value.append(SectionModel.init(model: "section", items: oneArray))
    }
    func configTwoArrayData()  {
        if dataArr.value.count > 1 {
            dataArr.value.remove(at: 1)
        }
        twoArray = [BSPostStyleModel.init(title: "溢价",
                                          content: "",
                                          coinType: "%",
                                          placHold: "根据市场的溢价比例",
                                          imgRight: true,
                                          inputType:.overFlow),
             
                    BSPostStyleModel.init(title: "最低价",
                                          content: "",
                                          coinType: "CNY",
                                          placHold: "广告最低可成交的价格",
                                          imgRight: true,
                                          inputType:.min_price),
                    BSPostStyleModel.init(title: "最小量",
                                          content: "",
                                          coinType: "CNY",
                                          placHold: "每一笔交易额的最小限额",
                                          imgRight: true,
                                          inputType:.min_num),
                    BSPostStyleModel.init(title: "最大量",
                                          content: "",
                                          coinType: "CNY",
                                          placHold: "每一笔交易额的最大限额",
                                          imgRight: true,
                                          inputType:.max_num),
                    BSPostStyleModel.init(title: "付款方式",
                                          content: "现金存款",
                                          coinType: "",
                                          placHold: "",
                                          inputType:.payType,
                                          isInput:false)]
        switch postType {
        case .Buy:
            twoArray.remove(at: 1)
            twoArray.append(BSPostStyleModel.init(title: "付款期限", content: "",coinType: "分钟", placHold: "请输入付款期限",imgRight: true,inputType:.payTime))
        case .Sale:
            break
        }
        dataArr.value.insert(SectionModel.init(model: "two", items: twoArray), at: 1)

        
    }
    func requestPostBuy()  {

        postModel.coin_type         = "1"
        postModel.member_id         = "13"

        let params:[String: Any] = postModel.toJSON()

        BSPostViewModel.requestPostBuyAdData(params).subscribe(onNext: { (message) in
            print(message)
        }).addDisposableTo(rx_disposeBag)
        
    }
    func toVC(_ indexpath:IndexPath?)  {
        guard let index = indexpath else {
            return
        }
        let section = index.section
        let row = index.row
        switch section {
        case 0:
            switch row {
                case 1:
                    VCRouter.toCountryVC( block: {[weak self] (str, id,code) in
                        guard let `self` = self else { return  }
                        for m in self.twoArray {
                            
                        }
                    })
                    break
                case 2:
                    VCRouter.toCountryVC(.Country, block: { (str, id,code) in
                        
                    })
                    break
                default:break
            }

        default:
            break
        }
    }
    func updateTwoArray()  {
        
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
