//
//  BSSearchUserController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/13.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSSearchUserController: BSBaseViewController {

    @IBOutlet weak var btnSearch: BSNextBtn!
    @IBOutlet weak var tfUser: UITextField!
    var params:[String:Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()

        tfUser.rx.text.subscribe(onNext: { [weak self](text) in
            
            guard let strongSelf = self else { return }
            strongSelf.params["nickname"] = text
            
        }).addDisposableTo(rx_disposeBag)
        
        //判断手机是否合法
        let userValid = tfUser.rx.text
            .map{$0!.characters.count > 0}
            .shareReplay(1)
        
        // 控制是否可以点击
        userValid.asObservable().bind(to: btnSearch.rx.isEnabled).disposed(by: rx_disposeBag)
        
 
        btnSearch.rx.tap.subscribe(onNext: { [unowned self] in
            VCRouter.toSearchADResultVC(self.params)
        }).addDisposableTo(rx_disposeBag)
    }

    @IBAction func searchAction(_ sender: Any) {
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
