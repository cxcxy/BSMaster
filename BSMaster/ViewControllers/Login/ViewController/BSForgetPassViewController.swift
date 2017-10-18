//
//  BSForgetPassViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/11.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSForgetPassViewController: BSBaseViewController {
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var btnNext: BSNextBtn!
    @IBOutlet weak var btnMsgCode: UIButton!
    @IBOutlet weak var viewCountry: UIView!
    @IBOutlet weak var lbCountryName: UILabel!
    
     var resetPassType : BSResetPassType = .LoginPassWord // 默认找回登录密码
    var mobile_type = "44" // 国家类型  默认中国 44
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
   
    }
    override func setUI() {
        super.setUI()
        
           //判断手机是否合法
        let phoneValid = tfPhone.rx.text
            .map{$0!.characters.count > 0 && $0!.characters.count <= 11 }
            .shareReplay(1)
        //判断验证码是否合法
        let codeValid = tfCode.rx.text
            .map{$0!.characters.count > 0 && $0!.characters.count <= 6 }
            .shareReplay(1)

        let everythingValid = Observable.combineLatest(phoneValid, codeValid) { (phoneValid, codeValid) -> Bool in
            phoneValid  && codeValid
        }
        
        // 控制btnNext 下一步 是否可点击
        everythingValid.bind(to: btnNext.rx.isEnabled).addDisposableTo(rx_disposeBag)
        


        
        // btnNext 点击监听
        btnNext.rx.tap.subscribe(onNext: { [unowned self]in
          self.checkCodeSure()
        }).addDisposableTo(rx_disposeBag)
        
        btnMsgCode.rx.tap.subscribe(onNext: { [unowned self] in
            self.getCode()
        }).addDisposableTo(rx_disposeBag)
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
    
      //MARK: 跳转 重置密码的界面前  先验证验证码是否 合法
    func checkCodeSure()  {
        
        BSRegisterViewModel.requestRegisterFisterData(tfPhone.text!, type: "2", verCode: tfCode.text!, mobile_type: self.mobile_type).subscribe(onNext: {[weak self] (message) in
            guard let `self` = self else { return  }
            self.toResetPassVC()

            
        }).addDisposableTo(rx_disposeBag)
        
    }
    // 跳转 设置 密码 界面
    func toResetPassVC()  {
    VCRouter.toResetPassVC(RegisterModel.init(phone: self.tfPhone.text!, verCode: self.tfCode.text!, passwWord: "", mobile_type: self.mobile_type),resetType:resetPassType)
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

  

}
