//
//  BSMobileListController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/16.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSCountryType {
    case Country   // "国家／地区"
    case Corrency  // 货币
}
class BSMobileListController: BSBaseViewController {
    var vc_type:BSCountryType = .Country
    var dataArr : [BSMobileListModel] = []
    
    var seletorBlock:ChooseCountryBlock?
    
    @IBOutlet weak var tableView: UITableView!
    //MARK:Lazy
    var headerIndexs:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch vc_type {
            case .Country:
             self.title = "国家／地区"
                break
            case .Corrency:
             self.title = "货币选择"
                break
        }
        
        tableView.cellId_register("BSDigtitalCell")
        
        request()

    }
    func cofigData(_ arr:[BSMobileListModel])  {
        var titleArr:[String] = []
        for model in arr {
            titleArr.append(model.title ?? "")
        }
        self.dataArr = arr
        headerIndexs = titleArr
        self.tableView.reloadData()
    }
    override func request() {
        super.request()
        switch vc_type {
        case .Country:
            BSMobileListViewModel.requestCurrencyListData("4").subscribe(onNext: {[weak self] (arr) in
                if let strongSelf = self {

                    strongSelf.cofigData(arr)
                }
                
            }).addDisposableTo(rx_disposeBag)
            break
        case .Corrency:
            
            BSMobileListViewModel.requestCurrencyListData("4").subscribe(onNext: {[weak self] (arr) in
                if let strongSelf = self {
//                    strongSelf.dataArr.value.append(SectionModel.init(model: "section", items: arr))
                    print(arr)
                }
                
            }).addDisposableTo(rx_disposeBag)
            break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension BSMobileListController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerIndexs.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArr[section].data?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = BSDigtitalCell.init(style: .default, reuseIdentifier: "BSDigtitalCell")
        cell.lbTitle.text = dataArr[indexPath.section].data?[indexPath.row].name ?? ""
        return cell
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerIndexs[section]
    }
    //实现索引数据源代理方法
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return headerIndexs
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let m  = dataArr[indexPath.section].data?[indexPath.row]
        if let bclok = seletorBlock {
            bclok(m?.name ?? "",m?.id ?? 0,m?.currency_code ?? "")

            self.popVC()
        }
    }
}
