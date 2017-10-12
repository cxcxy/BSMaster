//
//  BSHud.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
import SVProgressHUD

struct BSHud {

    static func showLoading(){
        DispatchQueue.main.async {
            SVProgressHUD.setFadeInAnimationDuration(0.0)
            SVProgressHUD.setFadeOutAnimationDuration(0.0)
            SVProgressHUD.setDefaultStyle(.custom)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.setForegroundColor(UIColor.white)
            SVProgressHUD.setBackgroundColor(MGRgb(0, g: 0, b: 0, alpha: 0.8))
            SVProgressHUD.show()
        }
        
    }
    static func dismiss(){
        DispatchQueue.main.async {
            
            SVProgressHUD.dismiss()

        }
    }
    // 提示语
    static func showMsg(_ message:String?){
        DispatchQueue.main.async {
            
            configSVHud()
            let msg = message ?? "网络错误"
            SVProgressHUD.showError(withStatus: msg)
        }
    }
  // 错误
    static func showWarnMsg(_ message:String?){
        DispatchQueue.main.async {
            
            configErrorSVHud()
            let msg = message ?? ""
            SVProgressHUD.showInfo(withStatus: msg)
        }
    }
    static func configSVHud(){
        SVProgressHUD.setFadeInAnimationDuration(0.0)
        SVProgressHUD.setFadeOutAnimationDuration(0.0)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setInfoImage(UIImage())
        SVProgressHUD.setImageViewSize(CGSize.init(width: 0, height: 0))
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(MGRgb(0, g: 0, b: 0, alpha: 0.8))
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
    static func configErrorSVHud(){
        SVProgressHUD.setFadeInAnimationDuration(0.0)
        SVProgressHUD.setFadeOutAnimationDuration(0.0)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.custom)
//        SVProgressHUD.setInfoImage(UIImage(named:"error")!)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(MGRgb(0, g: 0, b: 0, alpha: 0.8))
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
}
