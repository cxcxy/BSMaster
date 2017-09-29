//
//  BSBaseTabBar.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class BSBaseTabBar: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let images          =   ["tab_home","tab_shopping","tab_special","icon_brand","tab_me"]
        let imagesSelector  =   ["tab_home","tab_shopping","tab_special","icon_brand","tab_me"]
        let imagesTitle     =   ["交易","订单","","钱包","我的"]
        for title in imagesTitle.enumerated() {
            let vc = ViewController()
            vc.tabBarItem = ESTabBarItem.init(title: title.element,
                                              image: UIImage(named: images[title.offset]),
                                              selectedImage: UIImage(named: imagesSelector[title.offset]))
            
            let nav = BSBaseNavigation.init(rootViewController: vc)
            self.viewControllers?.append(nav)
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
