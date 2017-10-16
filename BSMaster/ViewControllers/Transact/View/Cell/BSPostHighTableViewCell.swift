//
//  BSPostHighTableViewCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPostHighTableViewCell: BSBaseTableViewCell {

    @IBOutlet weak var btnNoEnable: UIButton! //    不启用按钮
    @IBOutlet weak var btnEnable: UIButton! //      启用按钮
    var postModel : BSPostModel?
    override func awakeFromNib() {
        super.awakeFromNib()

        // 控制启用按钮的状态
        let enableObser = Variable(false)
        enableObser.asObservable().bind(to: btnEnable.rx.isSelected).disposed(by: rx_disposeBag)
        
        // 控制不启用 按钮的状态
        let noEnableObser = Variable(true)
        noEnableObser.asObservable().bind(to: btnNoEnable.rx.isSelected).disposed(by: rx_disposeBag)
        
        
        // 不启用点击事件
        btnNoEnable.rx.tap.subscribe(onNext: {[unowned self] in
            enableObser.value   = noEnableObser.value
            noEnableObser.value = !noEnableObser.value
            self.postModel?.is_safe = "2"
        }).addDisposableTo(rx_disposeBag)
        // 启用点击事件
        btnEnable.rx.tap.subscribe(onNext: {[unowned self] in
            noEnableObser.value = enableObser.value
            enableObser.value = !enableObser.value
            self.postModel?.is_safe = "1"
        }).addDisposableTo(rx_disposeBag)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
