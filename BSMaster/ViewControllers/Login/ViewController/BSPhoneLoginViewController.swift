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
    
    @IBOutlet weak var viewCountry: UIView!
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
        makeCustomerImageNavigationItem("close", left: true) {
            self.navigationController?.dismissVC(completion: nil)
        }
        self.loginViewModel =
            BSLoginViewModel.init(input: (phoneNumber: self.tfPhone.rx.text.orEmpty.asDriver(), password: self.tfPassword.rx.text.orEmpty.asDriver()))
        
       // 绑定到 btn 是否可点击状态
         self.loginViewModel?.signInEnabled.asObservable().bind(to: btnLogin.rx.isEnabled).addDisposableTo(rx_disposeBag)
        // btnLogin 点击监听 请求登录接口
        btnLogin.rx.tap.subscribe(onNext: {  [weak self]in
            self?.requstLogin()
        }).addDisposableTo(rx_disposeBag)
        
        viewCountry.addAction {
            VCRouter.toCountryVC( block: { (str, id,code) in
                
            })
        }
        // 点击忘记密码
        btnPassword.rx.tap.subscribe(onNext: {
            VCRouter.toForgetPassVC()
        }).addDisposableTo(rx_disposeBag)
        
    }
    //MARK: 请求登录接口 
    func requstLogin()  {
        self.loginViewModel?.requestLoginData(self.tfPhone.text!, password: self.tfPassword.text!).subscribe(onNext: { (message) in
            BSHud.showMsg(message)
        }).addDisposableTo(rx_disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
