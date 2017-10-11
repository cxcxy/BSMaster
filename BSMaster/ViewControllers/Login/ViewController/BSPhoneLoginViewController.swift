//
//  BSPhoneLoginViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/9.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSPhoneLoginViewController: BSBaseViewController {

    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnPassword: UIButton!
    
    private var loginViewModel : BSLoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
    }
    override func setUI() {
        super.setUI()
        
        makeCustomerNavigationItem("注册", left: false) {
            VCRouter.toRegistVC()
        }
        
        self.loginViewModel =
            BSLoginViewModel.init(input: (username: self.tfPhone.rx.text.orEmpty.asDriver(), password: self.tfPassword.rx.text.orEmpty.asDriver()))
        

        self.loginViewModel?.signInEnabled.drive(onNext: { [unowned self](isTrue) in
            if isTrue {
                self.btnLogin.backgroundColor = BSBtnColor
                self.btnLogin.setTitleColor(UIColor.white, for: .normal)
            }else {
                self.btnLogin.backgroundColor = UIColor.white
                self.btnLogin.setTitleColor(UIColor.init(hexString: "c1c5cc"), for: .normal)
            }
        }).addDisposableTo(rx_disposeBag)
      
        // 控制btnLogin 是否可点击
//        everythingValid.bind(to: btnLogin.rx.isEnabled).addDisposableTo(rx_disposeBag)
         self.loginViewModel?.signInEnabled.asObservable().bind(to: btnLogin.rx.isEnabled).addDisposableTo(rx_disposeBag)
        // btnLogin 点击监听
        btnLogin.rx.tap.subscribe(onNext: {  [weak self]in
            print("登录按钮")
        }).addDisposableTo(rx_disposeBag)
        btnPassword.rx.tap.subscribe(onNext: {  [weak self]in
            print("忘记密码")
        }).addDisposableTo(rx_disposeBag)
        
      
        btnLogin.layer.cornerRadius         = 7.0
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
