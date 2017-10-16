//
//  BSPostInputCell.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/12.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import KMPlaceholderTextView
class BSPostInputCell: BSBaseTableViewCell {
    var postModel : BSPostModel?
    @IBOutlet weak var inputTextView: KMPlaceholderTextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextView.rx.text.orEmpty.subscribe(onNext: { [unowned self](str) in
            self.postModel?.message = str
        }).addDisposableTo(rx_disposeBag)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
