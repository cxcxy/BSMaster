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
        
        everythingValid.subscribe(onNext: { [unowned self](isTrue) in
            if isTrue {
                self.btnNext.backgroundColor = BSBtnColor
                self.btnNext.setTitleColor(UIColor.white, for: .normal)
            }else {
                self.btnNext.backgroundColor = UIColor.white
                self.btnNext.setTitleColor(UIColor.init(hexString: "c1c5cc"), for: .normal)
            }
        }).addDisposableTo(rx_disposeBag)

        
        // btnNext 点击监听
        btnNext.rx.tap.subscribe(onNext: { [unowned self]in
          self.toResetPassVC()
        }).addDisposableTo(rx_disposeBag)
        btnMsgCode.rx.tap.subscribe(onNext: { [unowned self] in
            self.btnMsgCode.startTimer(60, title: "获取验证码", mainBGColor: UIColor.white, mainTitleColor: BSBtnColor, countBGColor: UIColor.white, countTitleColor: MGRgb(128, g: 128, b: 128), handle: nil)
        }).addDisposableTo(rx_disposeBag)
    }
      //MARK: 跳转 重置密码的界面
    func toResetPassVC()  {
        
        BSRegisterViewModel.requestRegisterFisterData(tfPhone.text!, type: "2", verCode: tfCode.text!, mobile_type: nil).subscribe(onNext: { (message) in
              VCRouter.toResetPassVC()
        }).addDisposableTo(rx_disposeBag)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

  

}
