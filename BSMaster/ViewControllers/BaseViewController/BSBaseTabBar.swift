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
        
        
        self.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
            
        }
        self.didHijackHandler = {
            [weak tabBarController] tabbarController , viewController, index in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {

                let vc = BSPushMaskViewController() // 弹出 选择 出售 还是 购买 弹窗
                tabbarController.presentToMaskViewController(viewControllerToPresent: vc)
                
            })
            
        }
        
        
        let storys          =   ["Transact","Order","Transact","Purse","My"]
        let images          =   ["tab_grayTransact","tab_grayOrder","","tab_grayPurse","tab_grayMe"]
        let imagesSelector  =   ["tab_transact","tab_grayOrder","","tab_grayPurse","tab_grayMe"]
        let imagesTitle     =   ["交易","订单","","钱包","我的"]
        
        var viewControllers = [UIViewController]()
        for title in imagesTitle.enumerated() {
            
            let vc = UIStoryboard.initialViewController(storys[title.offset])
            vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
            vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)

            
            if title.offset == 2 {
               vc.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "tab_chose"), selectedImage: UIImage(named: "tab_chose"))
            }else{
                vc.tabBarItem = ESTabBarItem.init(title: title.element,
                                                  image: UIImage(named: images[title.offset]),
                                                  selectedImage: UIImage(named: imagesSelector[title.offset]))
            }
           viewControllers.append(vc)
       
        }

        self.view.backgroundColor   = UIColor.white
//        self.tabBar.backgroundColor = UIColor(hexString: "#FFFFFF")
        self.tabBar.barTintColor    = UIColor.white
        self.tabBar.isTranslucent   = false
        self.viewControllers        = viewControllers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
class ExampleIrregularityContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor      = BSNavColor
        self.imageView.layer.borderWidth    = 3.0
        self.imageView.layer.borderColor    = UIColor.white.cgColor
        self.imageView.layer.cornerRadius   = 30
        self.insets                     = UIEdgeInsetsMake(-32, 0, 0, 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubview(toFront: self)
        
        textColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
        backdropColor = .clear
        highlightBackdropColor = .clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
    
        public override func selectAnimation(animated: Bool, completion: (() -> ())?) {
//            let view = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize(width: 2.0, height: 2.0)))
//            view.layer.cornerRadius = 1.0
//            view.layer.opacity = 0.5
//            view.backgroundColor = UIColor.init(red: 10/255.0, green: 66/255.0, blue: 91/255.0, alpha: 1.0)
//            self.addSubview(view)
  
        }
    //
        public override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
            completion?()
        }
    
        public override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
//            UIView.beginAnimations("big", context: nil)
//            UIView.setAnimationDuration(0.2)
//            let transform = CGAffineTransform.identity
//            self.imageView.transform = transform
//            UIView.commitAnimations()
//            completion?()
        }
    
//        public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
//            UIView.beginAnimations("small", context: nil)
//            UIView.setAnimationDuration(0.2)
//            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
//            UIView.commitAnimations()
//            completion?()
//        }
//
//        public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
//
//        }
    
    
}
