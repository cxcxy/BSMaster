//
//  BSDigitalCoinController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSTitleListType {
    case DigitalCoin // 数字货币
    case Language    // 语言
}


class BSDigitalCoinController: BSBaseTableViewController {
    
    var titleListType : BSTitleListType = .DigitalCoin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.cellId_register("BSDigtitalCell")
        
        switch titleListType {
        case .Language:
            self.title = "语言"
            makeCustomerNavigationItem("保存", left: false) {
                BSHud.showMsg("保存成功")
            }
            break
        default:
            self.title = "数字货币"
            break
        }
        
        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            
            let  cell = BSDigtitalCell.init(style: .default, reuseIdentifier: "BSDigtitalCell")
            return cell
            
        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx.itemSelected.subscribe {[unowned self] (indexpath) in
            
//            VCRouter.toBuyCoinVC()
        }.addDisposableTo(rx_disposeBag)
        
        dataArr.value.append(SectionModel.init(model: "section", items: ["1","1","1","1","1","1","1","1","1","1","1"]))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
class BSDigtitalCell: UITableViewCell {
    var lbTitle : UILabel!
    var lbLine :UILabel!
    var right_Icon:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setUI()  {
            lbTitle = UILabel()
            lbTitle.font = UIFont.systemFont(ofSize: 14)
            lbTitle.text = "比特币"
            lbTitle.textColor = MGRgb(25, g: 28, b: 39)
            self.addSubview(lbTitle)
            lbLine = UILabel()
            lbLine.backgroundColor = MGRgb(221, g: 226, b: 228)
            self.addSubview(lbLine)
        
        
            right_Icon = UIImageView()
            right_Icon.image = UIImage.init(named: "right")
            self.addSubview(right_Icon)
        
            lbTitle.snp.makeConstraints { [unowned self](make) in
                make.left.equalTo(15)
                make.centerY.equalTo(self)
                make.height.equalTo(50)
            }
        lbLine.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(1)
            make.bottom.equalTo(0)
        }
        right_Icon.snp.makeConstraints { (make) in
//            make.left.equalTo(15)
             make.right.equalTo(-15)
            make.height.equalTo(13)
            make.width.equalTo(7)
            make.centerY.equalTo(self)
//            make.bottom.equalTo(0)
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
