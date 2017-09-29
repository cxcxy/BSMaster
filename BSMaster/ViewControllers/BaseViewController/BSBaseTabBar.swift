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
        
        let storys          =   ["Transact","Order","Transact","Purse","My"]
        let images          =   ["tab_home","tab_shopping","tab_special","icon_brand","tab_me"]
        let imagesSelector  =   ["tab_home","tab_shopping","tab_special","icon_brand","tab_me"]
        let imagesTitle     =   ["交易","订单","","钱包","我的"]
        
        var viewControllers = [UIViewController]()
        for title in imagesTitle.enumerated() {
            
            let vc = UIStoryboard.initialViewController(storys[title.offset])
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
            vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
            vc.tabBarItem = ESTabBarItem.init(title: title.element,
                                              image: UIImage(named: images[title.offset]),
                                              selectedImage: UIImage(named: imagesSelector[title.offset]))
            

           viewControllers.append(vc)
       
        }
        self.viewControllers = viewControllers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

