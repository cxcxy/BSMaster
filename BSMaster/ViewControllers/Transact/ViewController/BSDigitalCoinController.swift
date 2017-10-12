//
//  BSDigitalCoinController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSDigitalCoinController: BSBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "数字货币"
        tableView.delegate      = nil
        tableView.dataSource    = nil
        tableView.cellId_register("BSDigtitalCell")
        
        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            
//            var cell = tableView.dequeueReusableCell(withIdentifier: "BSDigtitalCell", for: indexPath) as! BSDigtitalCell
//            if cell == nil {
            
              let  cell = BSDigtitalCell.init(style: .default, reuseIdentifier: "BSDigtitalCell")
//            }
            return cell
            
        }
        
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        tableView.rx
            .setDelegate(self)
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
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
