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
public extension UIStoryboard {
    /**
     根据stroyboard名称返回初始控制器
     
     - parameter name: 名称
     
     - returns: 初始控制器
     */
    class func initialViewController(_ name: String) -> UIViewController {
        let sb = UIStoryboard(name: name, bundle: Bundle.main)
        return sb.instantiateInitialViewController()!
    }
    
    /**
     根据stroyboard名称和标示符返回对应的控制器
     
     - parameter name:       名称
     - parameter identifier: 标示符
     
     - returns: 对应的控制器
     */
    class func initialViewController(_ name: String, identifier: String) -> UIViewController
    {
        let sb = UIStoryboard(name: name, bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier)
    }
    
    
    class func initNavVC(_ name: String, identifier: String) -> UINavigationController {
        let sb      = UIStoryboard(name: name, bundle: nil)
        let nav_vc  = UINavigationController.init(rootViewController: sb.instantiateViewController(withIdentifier: identifier))
        
        return nav_vc
    }
    
}
