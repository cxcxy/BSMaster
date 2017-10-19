//
//  BSBaseViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomerBack()
        setUI()
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    //MARK:配置 UI
    func setUI()  {
        self.view.backgroundColor = UIColor.white
    }
    //MARK: 返回按钮
    func setCustomerBack() {
        if let count = navigationController?.viewControllers.count {
            if count > 1 {
                let item = UIBarButtonItem(image:UIImage(named: "nav_Back"), style:.plain, target: self, action:#selector(navBack))
                navigationItem.leftBarButtonItem = item
            }
        }
    }
    func navBack() {
        _ = navigationController?.popViewController(animated: true)
    }
    func request()  {
        
    }
    deinit {
        
        BSLog("Title: == \(String(describing: self.title)) VC: == \(self.identifier())  --- 销毁")
        
    }

}
// 空白展位图
extension BSBaseViewController:DZNEmptyDataSetDelegate,DZNEmptyDataSetSource{
    @objc(titleForEmptyDataSet:) func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {

        return BSNoDataTitle
    }
    @objc(backgroundColorForEmptyDataSet:) func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return tableColor
    }
    
}
