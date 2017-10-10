//
//  UIViewControllerRouter.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/9.
//  Copyright © 2017年 陈旭. All rights reserved.
//

public class VCRouter {
    //TODO: 栈顶部 导航条控制器
    public class var topNaVC : UINavigationController? {
        
        get {
            let topViewController = BSUtil.currentTopViewController()
            let navigation = topViewController.navigationController
            return navigation
        }
    }
    //TODO: 栈顶部 导航条控制器
    public class var topVC : UIViewController? {
        
        get {
            let topViewController = BSUtil.currentTopViewController()
            return topViewController
        }
    }
    //MARK: 跳转登录界面
   public class func toLoginVC(){
        let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSLoginViewController")
        let nav = UINavigationController.init(rootViewController: vc)
        topNaVC?.presentVC(nav)
    }
    //MARK: 跳转设置界面
    public class func toSettingVC(){
        let vc = BSSettingViewController.init(style: .grouped)
        topVC?.pushVC(vc)
    }
    //MARK: 跳转广告界面
    public class func toADVC(_ type:BSSegmentStyle = .Adverted){
        let vc = BSMyAdverteViewController()
        vc.controllerStyle = type
          topVC?.pushVC(vc)
    }
}

