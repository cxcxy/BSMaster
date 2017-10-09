//
//  UIStoryboard+.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//
public enum StoryBoardName:String {
    case Transact = "Transact"
    case Order    = "Order"
    case Main     = "Main"
    case Purse    = "Purse"
    case My       = "My"
    case Login    = "Login"
}
public extension UIStoryboard {
    // 根据stroyboard名称返回初始控制器
    class func initialViewController(_ name: String) -> UIViewController {
        let sb = UIStoryboard(name: name, bundle: Bundle.main)
        return sb.instantiateInitialViewController()!
    }
    
    class func initNavVC(_ name: String, identifier: String) -> UINavigationController {
        let sb      = UIStoryboard(name: name, bundle: nil)
        let nav_vc  = UINavigationController.init(rootViewController: sb.instantiateViewController(withIdentifier: identifier))
        
        return nav_vc
    }
    
    // 根据stroyboard名称和标示符返回对应的控制器
   class func getStoryVC(_ story: StoryBoardName ,identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: story.rawValue, bundle: Bundle.main)
        return sb.instantiateViewController(withIdentifier: identifier)
    }
}
