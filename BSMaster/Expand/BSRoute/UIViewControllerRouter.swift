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
        let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSPhoneLoginViewController")
        let nav = BSBaseNavigation.init(rootViewController: vc)
        topVC?.presentVC(nav)
    }
    //MARK: 跳转注册界面
    public class func toRegistVC(){
        let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSRegistViewController")
        topVC?.pushVC(vc)
    }
    //MARK: 跳转设置昵称界面
    public class func toSetNickVC(_ model:RegisterModel){
        let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSSetNickViewController") as! BSSetNickViewController
        vc.registerModel = model
        topVC?.pushVC(vc)
    }
    //MARK: 跳转忘记密码界面
    public class func toForgetPassVC(){
        let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSForgetPassViewController") as! BSForgetPassViewController
        topVC?.pushVC(vc)
    }
    //MARK: 跳转重置密码界面
    public class func toResetPassVC(){
        let vc = UIStoryboard.getStoryVC(.Login, identifier: "BSResetViewController") as! BSResetViewController
        topVC?.pushVC(vc)
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

    //TODO: 购买 出售比特币
    public class func toBuyCoinVC(){
        let vc = UIStoryboard.getStoryVC(.Transact, identifier: "BSTransactDetailViewController") as! BSTransactDetailViewController
        topVC?.pushVC(vc)
    }
    //TODO: 弹出蒙层
    public class func toPrensMaskVC(){
        let vc = UIStoryboard.getStoryVC(.Transact, identifier: "BSTransactDetailViewController") as! BSTransactDetailViewController
        let nav = BSBaseNavigation.init(rootViewController: vc)
        topVC?.presentVC(nav)
    }
}

