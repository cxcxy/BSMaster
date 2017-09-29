//
//  BSTransactDetailViewController.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit

class BSTransactDetailViewController: BSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        let img = UIImageView.init(frame: CGRect.init(x: 10, y: 100, w: 300, h: 300))
        img.set_Img_Url("https://camo.githubusercontent.com/3b186bfb4c2df6651f7b76e2fa28fbd60476f0e6/687474703a2f2f696d61676573302e636e626c6f67732e636f6d2f626c6f67323031352f3439373237392f3230313530362f3134313231323336353034313635302e706e67")
        self.view.addSubview(img)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
