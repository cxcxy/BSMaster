//
//  BSResetFiestViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSResetFiestViewController: BSBaseViewController {
    
    var resetPassType : BSResetPassType = .LoginPassWord
    
    @IBOutlet weak var lbDes: UILabel!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var btnNext: BSNextBtn!
    @IBOutlet weak var btnForgetPass: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        switch resetPassType {
        case .LoginPassWord,.LoginOldPassWord:
            self.title = "重置登录密码"
            self.lbDes.text = "修改您的登录密码"
            self.tfPass.placeholder = "输入原登录密码"
        case .MoneyPassWord,.MoneyOldPassWord:
            self.title = "重置资金密码"
            self.tfPass.placeholder = "输入原资金密码"
        }
        

    }
    override func setUI() {
        super.setUI()
        
        //判断密码是否合法
        let password    = tfPass.rx.text
            .map{ $0!.characters.count > 0 }
            .shareReplay(1)
   
        // 控制btnNext 下一步 是否可点击
        password.bind(to: btnNext.rx.isEnabled).addDisposableTo(rx_disposeBag)
        
        // btn 点击监听 请求接口
        btnForgetPass.rx.tap.subscribe(onNext: {[unowned self] in
            print("忘记密码")
            VCRouter.toForgetPassVC(self.resetPassType)
        }).addDisposableTo(rx_disposeBag)
        
        btnNext.rx.tap.subscribe(onNext: {[unowned self] in
 
            self.judgmentOldPass()
          
        }).addDisposableTo(rx_disposeBag)
    }
    // 判断原来密码是否正确
    func judgmentOldPass()  {
        let type = resetPassType == .LoginOldPassWord ? "2" : "1"
        BSPassViewModel.requestJudgmentOldPassData(tfPass.text!, type: type, member_id: "22").subscribe(onNext: { [unowned self](message) in
            self.toVC()
        }).addDisposableTo(rx_disposeBag)
    }
    func toVC()  {
     
        VCRouter.toResetPassVC( oldPass: tfPass.text!, resetType: resetPassType)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
