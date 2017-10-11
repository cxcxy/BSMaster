//
//  BSRegistViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/10.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSRegistViewController: BSBaseViewController {

    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSelector: UIButton!
    @IBOutlet weak var btnNext: BSNextBtn!
    @IBOutlet weak var btnMsgCode: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
    }
    override func setUI() {
        super.setUI()
        
        makeCustomerNavigationItem("登录", left: false) {
           
        }
        //判断手机是否合法
        let phoneValid = tfPhone.rx.text
            .map{$0!.characters.count > 0 && $0!.characters.count <= 11 }
            .shareReplay(1)
        //判断验证码是否合法
        let codeValid = tfCode.rx.text
            .map{$0!.characters.count > 0 && $0!.characters.count <= 6 }
            .shareReplay(1)
        //判断密码是否合法
        let passwordValid = tfPassword.rx.text
            .map{ $0!.characters.count >= 6 && $0!.characters.count < 16 }
            .shareReplay(1)
    
        // 控制同意协议 按钮的状态
        let selectorObser = Variable(false)
        selectorObser.asObservable().bind(to: btnSelector.rx.isSelected).disposed(by: rx_disposeBag)
        
        let checkBtnValid = selectorObser.asObservable().map { $0 }.shareReplay(1)

        // 手机合法 且 密码 合法 ---- 集合
        let everythingValid = Observable.combineLatest(phoneValid, passwordValid, codeValid,checkBtnValid) { (usernameValid, passwordValid, codeValid,checkBtnValid) -> Bool in
            usernameValid && passwordValid && codeValid && checkBtnValid
        }
        
        everythingValid.subscribe(onNext: { [unowned self](isTrue) in
            if isTrue && self.btnSelector.isSelected {
                self.btnNext.backgroundColor = BSBtnColor
                self.btnNext.setTitleColor(UIColor.white, for: .normal)
            }else {
                self.btnNext.backgroundColor = UIColor.white
                self.btnNext.setTitleColor(UIColor.init(hexString: "c1c5cc"), for: .normal)
            }
        }).addDisposableTo(rx_disposeBag)
        // 控制btnLogin 是否可点击
        everythingValid.bind(to: btnNext.rx.isEnabled).addDisposableTo(rx_disposeBag)
        // btnLogin 点击监听
        btnNext.rx.tap.subscribe(onNext: { [unowned self] in
            print("登录按钮")
        }).addDisposableTo(rx_disposeBag)
        
        // 同意协议
        btnSelector.rx.tap.subscribe(onNext: {
            selectorObser.value = !selectorObser.value
        }).addDisposableTo(rx_disposeBag)
        // 获取验证码
        btnMsgCode.rx.tap.subscribe(onNext: { [unowned self] in
            self.btnMsgCode.startTimer(60, title: "获取验证码", mainBGColor: UIColor.white, mainTitleColor: BSBtnColor, countBGColor: UIColor.white, countTitleColor: MGRgb(128, g: 128, b: 128), handle: nil)
        }).addDisposableTo(rx_disposeBag)
        
    }
    @IBAction func nextAction(_ sender: Any) {
        
            VCRouter.toSetNickVC()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
