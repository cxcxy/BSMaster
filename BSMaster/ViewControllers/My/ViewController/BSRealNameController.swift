//
//  BSRealNameController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSRealNameController: BSBaseViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var btnSelector: UIButton!
    @IBOutlet weak var btnSure: BSNextBtn!
    private var realNameViewModel : BSRealNameViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "实名认证"
        
        // 控制同意协议 按钮的状态
        let selectorObser = Variable(false)
        selectorObser.asObservable().bind(to: btnSelector.rx.isSelected).disposed(by: rx_disposeBag)
        
//        self.registerViewModel =
//            BSRegisterViewModel.init(input: (phoneNumber: self.tfPhone.rx.text.orEmpty.asDriver(),
//                                             password: self.tfPassword.rx.text.orEmpty.asDriver(),
//                                             verCode:self.tfCode.rx.text.orEmpty.asDriver(),
//                                             isSelect:selectorObser.asDriver()))
        
        
        self.realNameViewModel =
            BSRealNameViewModel.init(input: (nameInput: self.tfName.rx.text.orEmpty.asDriver(),
                                             codeInput: self.tfCode.rx.text.orEmpty.asDriver(),
                                             isSelect:selectorObser.asDriver()))
        
        // 同意协议
        btnSelector.rx.tap.subscribe(onNext: {
            selectorObser.value = !selectorObser.value
        }).addDisposableTo(rx_disposeBag)
        
        // 绑定到 btn 是否可点击状态
        self.realNameViewModel?.signInEnabled.asObservable().bind(to: btnSure.rx.isEnabled).addDisposableTo(rx_disposeBag)
        // btnLogin 点击监听 请求登录接口
        btnSure.rx.tap.subscribe(onNext: {  [weak self]in
       
        }).addDisposableTo(rx_disposeBag)
    }

    @IBAction func sureAction(_ sender: Any) {
        print("实名认证")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
