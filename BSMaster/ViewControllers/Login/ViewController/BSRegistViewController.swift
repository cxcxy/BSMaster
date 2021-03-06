//
//  BSRegistViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/10.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSRegistViewController: BSBaseViewController {

    @IBOutlet weak var lbCountryName: UILabel!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSelector: UIButton!
    @IBOutlet weak var btnNext: BSNextBtn!
    @IBOutlet weak var btnMsgCode: UIButton!
    
    @IBOutlet weak var viewCountry: UIView!
    private var registerViewModel : BSRegisterViewModel?
    
    var mobile_type = "44" // 国家类型  默认中国 44
    
    @IBOutlet weak var viewRegistDelegate: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
    }
    override func setUI() {
        super.setUI()
        
        // 控制同意协议 按钮的状态
        let selectorObser = Variable(false)
        selectorObser.asObservable().bind(to: btnSelector.rx.isSelected).disposed(by: rx_disposeBag)
        
        self.registerViewModel =
            BSRegisterViewModel.init(input: (phoneNumber: self.tfPhone.rx.text.orEmpty.asDriver(),
                                             password: self.tfPassword.rx.text.orEmpty.asDriver(),
                                             verCode:self.tfCode.rx.text.orEmpty.asDriver(),
                                             isSelect:selectorObser.asDriver()))
        
        
        // 控制btnNext 下一步 是否可点击
         self.registerViewModel?.nextInEnabled.asObservable().bind(to: btnNext.rx.isEnabled).addDisposableTo(rx_disposeBag)
    
//        // btnLogin 点击监听
//        btnNext.rx.tap.subscribe(onNext: { [unowned self] in
//            print("登录按钮")
//        }).addDisposableTo(rx_disposeBag)
        
        // 同意协议
        btnSelector.rx.tap.subscribe(onNext: {
            selectorObser.value = !selectorObser.value
        }).addDisposableTo(rx_disposeBag)
        // 获取验证码
        btnMsgCode.rx.tap.subscribe(onNext: { [unowned self] in
            self.getCode()
        }).addDisposableTo(rx_disposeBag)
        
        // 选择国家点击
        viewCountry.addAction {[unowned self] in
            VCRouter.toCountryVC( block: { (str, id,code) in
                self.lbCountryName.text = "国家／地区：" + str
                self.mobile_type = id.toString
            })
        }
        
    }
    //MARK: 获取验证码接口
    func getCode()  {

        guard tfPhone.text != "" else {
            BSHud.showMsg("请输入手机号")
            return
        }
        
        BSRegisterViewModel.requestPoseCodeData(tfPhone.text!).subscribe(onNext: { [weak self](message) in
            guard let `self` = self else { return  }
            BSHud.showMsg(message)
            self.btnMsgCode.startTimer(60, title: "获取验证码", mainBGColor: UIColor.white, mainTitleColor: BSBtnColor, countBGColor: UIColor.white, countTitleColor: MGRgb(128, g: 128, b: 128), handle: nil)

            
        } ).addDisposableTo(rx_disposeBag)
    }
    
    //MARK: 判断信息是否有效
    @IBAction func nextAction(_ sender: Any) {
        
        BSRegisterViewModel.requestRegisterFisterData(self.tfPhone.text!, type: "1", verCode: tfCode.text!, mobile_type: mobile_type).subscribe(onNext: { [unowned self](message) in
            BSLog(message)
            self.toNextVC()
        }).addDisposableTo(rx_disposeBag)
        
        
    }
    //MARK: 跳转 设置昵称的界面
    func toNextVC(){
        let registerData = RegisterModel.init(phone: self.tfPhone.text!, verCode: self.tfCode.text!, passwWord: self.tfPassword.text!, mobile_type: "44")
        
        VCRouter.toSetNickVC(registerData)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

