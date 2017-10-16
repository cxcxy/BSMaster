//
//  BSResetViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/11.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSResetPassType {
    case LoginPassWord
    case MoneyPassWord
}
class BSResetViewController: BSBaseViewController {
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfTwoPassword: UITextField!

    @IBOutlet weak var btnSure: UIButton!
    
    var forgetInfo : RegisterModel!
    
    
    @IBOutlet weak var lbDes: UILabel!
    var changePassType : BSResetPassType = .LoginPassWord
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch changePassType {
        case .LoginPassWord:
             self.title         = "重置登录密码"
             self.lbDes.text    = "设置登录密码"
        case .MoneyPassWord:
             self.title         = "重置资金密码"
             self.lbDes.text    = "设置资金密码将用于比特币的提款，保护您的比特币不被他人轻易盗用"
             self.tfPassword.placeholder         = "请设置提款密码"
             self.tfTwoPassword.placeholder      = "请再次确认您的密码"
        }
    }
    override func setUI() {
        super.setUI()

        //判断第一次输入密码是否合法
        let password    = tfPassword.rx.text
            .map{ $0!.characters.count >= 6 && $0!.characters.count <= 16 }
            .shareReplay(1)
        //判断第二次输入密码是否合法
        let twoPassword = tfTwoPassword.rx.text
            .map{ $0!.characters.count >= 6 && $0!.characters.count <= 16 }
            .shareReplay(1)
        
        let everythingValid = Observable.combineLatest(password, twoPassword) { (password, twoPassword) -> Bool in
            password  && twoPassword
        }
        // 控制btnNext 下一步 是否可点击
        everythingValid.bind(to: btnSure.rx.isEnabled).addDisposableTo(rx_disposeBag)
       
        // btnSure 点击监听
        btnSure.rx.tap.subscribe(onNext: { [unowned self] in
            self.clickSure()
        }).addDisposableTo(rx_disposeBag)
    }
    //MARK: 确定修改密码
    func clickSure()  {
        
        if tfPassword.text == tfTwoPassword.text {
            
            BSPassViewModel.requestResetPassData(forgetInfo.phone, password: tfPassword.text!, verCode: forgetInfo.verCode, mobile_type: "1").subscribe(onNext: { (message) in
                BSHud.showMsg(message)
            }).addDisposableTo(rx_disposeBag)
            
        }else {
            BSHud.showWarnMsg("密码输入不一致")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
