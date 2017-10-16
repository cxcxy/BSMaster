//
//  BSSetNickViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/11.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSSetNickViewController: BSBaseViewController {

    @IBOutlet weak var tfNick: UITextField!
    @IBOutlet weak var btnRegister: BSNextBtn!
    var registerModel :RegisterModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置昵称"
    }
    override func setUI() {
        super.setUI()
        //判断手机是否合法
        let nickValid = tfNick.rx.text
            .map{$0!.characters.count > 0}
            .shareReplay(1)
        
        // 控制是否可以点击
        nickValid.asObservable().bind(to: btnRegister.rx.isEnabled).disposed(by: rx_disposeBag)
        
        // 完成注册 点击监听
        btnRegister.rx.tap.subscribe(onNext: { [unowned self] in
            self.requstRegister()
        }).addDisposableTo(rx_disposeBag)
        
    }
    // 注册接口请求
    func requstRegister()  {

        BSRegisterViewModel.requestRegisterData(registerModel.phone,
                                                password: registerModel.passwWord,
                                                verCode: registerModel.verCode,
                                                nickName: tfNick.text!,
                                                mobile_type: "44").subscribe(onNext: {[unowned self] (message) in
                                                    BSHud.showMsg(message)
                                                    self.popToRootVC()
                                                }).addDisposableTo(rx_disposeBag)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
