//
//  BSSuggestController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSSuggestController: BSBaseTableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "建议反馈"

        tableView.cellId_register("BSSuggestCell")
        tableView.cellId_register("BSSuggestTitleCell")
        tableView.backgroundColor = UIColor.white
        dataSource.configureCell = {(_ , tableView , indexPath , element) in
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSSuggestCell", for: indexPath) as! BSSuggestCell
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BSSuggestTitleCell", for: indexPath) as! BSSuggestTitleCell
                return cell
            }


        }
        dataArr.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(rx_disposeBag)
        
        dataArr.value.append(SectionModel.init(model: "one", items: [1,2,3,4]))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
}
extension BSSuggestController {

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = BSFooterBtnView.init(frame: CGRect.init(x: 0, y: 0, w: MGScreenWidth, h: 70))
        view.b.setTitle("提交", for: .normal)
        return view
    }
}
class BSFooterBtnView: UIView {
    var b:UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        b                   = UIButton(type: .custom)
        b.frame             = CGRect(x: 0, y: 0, width: MGScreenWidth - 70, height: 50)
        b.titleLabel!.font  =  UIFont.systemFont(ofSize: 15)
        b.layer.cornerRadius         = 7.0
        b.addBorder(width: 0.5, color: BSBorderColor)
        b.setTitleColor(UIColor.white, for: .normal)
        b.setTitleColor(MGRgb(193, g: 197, b: 204), for: .disabled)
        b.setBackgroundColor(BSBtnColor, forState: .normal)
        b.setBackgroundColor(UIColor.white, forState: .disabled)
        self.addSubview(b)
        b.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.height.equalTo(50)
            make.right.equalTo(-30)
            make.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
