//
//  BSSreenDateView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSSreenDateView: ETPopupView {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var sureButton: UIButton!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        type = .sheet
        ETPopupWindow.sharedWindow().touchWildToHide = true
        animationDuration = 0.2
        self.snp.makeConstraints { (make) in
            make.width.equalTo(MGScreenWidth)
            make.height.equalTo(250)
        }
        pickerView.maximumDate = Date.init()
    }
    
    
    
    func showPickerView(dateStr: String?) {
        if let str = dateStr {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let date: Date = (formatter.date(from: str)) ?? Date.init()
            pickerView.date = date
        }
        show()
    }
    @IBAction func sureAction (_ sender: UIButton) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let str = formatter.string(from: pickerView.date)
        //        if let block = selectBlock {
        //
        //            block(str,0)
        //
        //        }
        hide()
    }
    
    @IBAction func cancelAction (_ sender: UIButton) {
        hide()
    }
}
