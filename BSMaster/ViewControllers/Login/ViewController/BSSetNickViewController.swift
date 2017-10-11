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
        nickValid.subscribe(onNext: { [unowned self](isTrue) in
            if isTrue  {
                self.btnRegister.backgroundColor = BSBtnColor
                self.btnRegister.setTitleColor(UIColor.white, for: .normal)
            }else {
                self.btnRegister.backgroundColor = UIColor.white
                self.btnRegister.setTitleColor(UIColor.init(hexString: "c1c5cc"), for: .normal)
            }
        }).addDisposableTo(rx_disposeBag)
        
        nickValid.asObservable().bind(to: btnRegister.rx.isSelected).disposed(by: rx_disposeBag)
        
    }
    @IBAction func registerAction(_ sender: Any) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}
