//
//  BSResetViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/11.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
enum BSResetPassType {
    case LoginPassWord // 忘记密码--重置登录密码
    case MoneyPassWord // 忘记密码--重置资金密码
    
    case LoginOldPassWord // 原密码--重置资金密码
    case MoneyOldPassWord // 原密码--重置资金密码
}
class BSResetViewController: BSBaseViewController {
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfTwoPassword: UITextField!

    @IBOutlet weak var btnSure: UIButton!
    
    var forgetInfo : RegisterModel?
    
    var oldPass:String?
    @IBOutlet weak var lbDes: UILabel!
    var resetPassType : BSResetPassType = .LoginPassWord
    var member_id = "22"
    override func viewDidLoad() {
        super.viewDidLoad()
        switch resetPassType {
        case .LoginPassWord,.LoginOldPassWord:
             self.title         = "重置登录密码"
             self.lbDes.text    = "设置登录密码"
        case .MoneyPassWord,.MoneyOldPassWord:
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
            switch resetPassType {
            case .LoginPassWord:
                BSPassViewModel.requestForgetLoginPassData(forgetInfo?.phone ?? "", password: tfPassword.text!, verCode: forgetInfo?.verCode ?? "", mobile_type: "44").subscribe(onNext: { (message) in
                    BSHud.showMsg(message)
                }).addDisposableTo(rx_disposeBag)
                break
            case .MoneyPassWord:
//                BSPassViewModel.requestSetPayPassData(member_id, password: tfPassword.text!).subscribe(onNext: { (message) in
//                    BSHud.showMsg(message)
//                }).addDisposableTo(rx_disposeBag)
                break
            case .LoginOldPassWord:
                let oldPass = self.oldPass ?? ""
                BSPassViewModel.requestChangePassOldData(oldPass, password: tfPassword.text!, member_id: member_id).subscribe(onNext: { (message) in
                    BSHud.showMsg(message)
                }).addDisposableTo(rx_disposeBag)
                
                break
            case .MoneyOldPassWord:
               let oldPass = self.oldPass ?? ""
                BSPassViewModel.requestChangeOldPayPassData(oldPass, password: tfPassword.text!, member_id: member_id).subscribe(onNext: { (message) in
                    BSHud.showMsg(message)
                }).addDisposableTo(rx_disposeBag)
                break
            }
            
        }else {
            BSHud.showWarnMsg("密码输入不一致")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
