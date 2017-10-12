//
//  BSResetViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/11.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSResetViewController: BSBaseViewController {
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfTwoPassword: UITextField!
    @IBOutlet weak var btnNext: BSNextBtn!
    @IBOutlet weak var btnSure: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "重置登录密码"
        // Do any additional setup after loading the view.
    }
    override func setUI() {
        super.setUI()

        //判断手机是否合法
        let password    = tfPassword.rx.text
            .map{ $0!.characters.count >= 6 && $0!.characters.count <= 16 }
            .shareReplay(1)
        //判断验证码是否合法
        let twoPassword = tfTwoPassword.rx.text
            .map{ $0!.characters.count >= 6 && $0!.characters.count <= 16 }
            .shareReplay(1)
        
        let everythingValid = Observable.combineLatest(password, twoPassword) { (password, twoPassword) -> Bool in
            password  && twoPassword
        }
        
        everythingValid.subscribe(onNext: { [unowned self](isTrue) in
            if isTrue{
                self.btnNext.backgroundColor = BSBtnColor
                self.btnNext.setTitleColor(UIColor.white, for: .normal)
            }else {
                self.btnNext.backgroundColor = UIColor.white
                self.btnNext.setTitleColor(UIColor.init(hexString: "c1c5cc"), for: .normal)
            }
        }).addDisposableTo(rx_disposeBag)
        
        // btnSure 点击监听
        btnSure.rx.tap.subscribe(onNext: { [unowned self] in
            self.clickSure()
        }).addDisposableTo(rx_disposeBag)
    }
    //MARK: 确定修改密码
    func clickSure()  {
        
        if tfPassword.text == tfTwoPassword.text {
            
            BSPassViewModel.requestResetPassData("15981870366", password: "000000", verCode: "123456", mobile_type: nil).subscribe(onNext: { (message) in
                BSHud.showMsg(message)
            }).addDisposableTo(rx_disposeBag)
            
//            self.popToRootVC()
        }else {
            BSHud.showWarnMsg("密码输入不一致")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
