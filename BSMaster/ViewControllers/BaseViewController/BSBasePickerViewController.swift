//
//  BSBasePickerViewController.swift
//  swift-BaseMask
//
//  Created by 陈旭 on 2017/5/15.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
typealias SelectRowBlock =  (_ str:String, _ index: Int) -> ()

class BSBasePickerViewController: BSBaseMackViewController {
    var selectBlock :SelectRowBlock?
    
    var dataArr:[String] = [] {
        didSet{
            basePikerView.dataArr = dataArr
        }
    }
    lazy var basePikerView:BSPickerView = {[unowned self] in
        
        let v = BSPickerView.loadFromNib()
        v.frame = CGRect.init(x: 0, y: MGScreenHeight - 250, width: MGScreenWidth, height: 250)
        v.sureButton.addTarget(self, action:#selector(surePicker), for:.touchUpInside)
        v.cancelButton.addTarget(self, action: #selector(dismissBtn), for: .touchUpInside)
        return v
        
    }()

    func showPicker(arr:[String],index:Int = 0)  {
        dataArr = arr
        basePikerView.pickerView.selectRow(index, inComponent: 0, animated: true)
    }
    func surePicker()  {
        
        let row = basePikerView.pickerView.selectedRow(inComponent: 0)
        let str = dataArr[row]
        
        if let block = selectBlock {
            
            block(str,row)
            
        }
        
        dismissBtn()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.containsView = self.basePikerView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
