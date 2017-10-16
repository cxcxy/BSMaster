//
//  BSPickerView.swift
//  swift-BaseMask
//
//  Created by 陈旭 on 2017/5/15.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPickerView: UIView,UIPickerViewDataSource, UIPickerViewDelegate {
    var dataArr:[String] = [] {
        didSet{
            pickerView.reloadAllComponents()
        }
    }
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var sureButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let str = dataArr[row]
        
        return str
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
