//
//  BSBaseSegmentedControl.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/30.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import VTMagic
/*-- 顶部 segment 视图  内容为 Controllers 基类--*/
class BSBaseSegmentedControl: BSBaseViewController {
    var controllerArray     : [UIViewController] = [] { // 存放controller 的array
        didSet{
            configMagicView()
        }
    }
    
    var selectCurrentIndex  : Int? = 0
    var v                   : VCVTMagic!
    
    var titleSegmentArray :Array<String> = [] { // 顶部segment title 数组，
        didSet{
            configSegmentNavition()
        }
    }
    var segment :UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:配置顶部 segment
    func configSegmentNavition()  {
        segment = UISegmentedControl.init(items: titleSegmentArray)
        segment.frame.size = CGSize.init(width: 180, height: 20)
        segment.addSelectorAction {[unowned self] (selectorIndex) in
            
            self.v.magicView.switch(toPage: UInt (selectorIndex), animated: true)
            
        }
        self.navigationItem.titleView = segment
    }
    //MARK:配置所对应的左右滑动View
    func configMagicView()  {
        v                                       = VCVTMagic()
        v.magicView.dataSource                  = self
        v.magicView.delegate                    = self
        v.magicView.navigationView.isHidden     = true
        v.magicView.navigationHeight            = 0
        self.addChildViewController(v)
        self.view.addSubview(v.magicView)
        v.magicView.snp.makeConstraints {[weak self] (make) -> Void in
            if let strongSelf = self {
                make.size.equalTo(strongSelf.view)
                
            }
        }
        v.magicView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
//MARK:VTMagicViewDataSource
extension BSBaseSegmentedControl:VTMagicViewDataSource{
    
    func menuTitles(for magicView: VTMagicView) -> [String] {
        return titleSegmentArray
    }
    func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton{
        return UIButton(type: .custom)
    }
    func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController{
        return controllerArray[Int(pageIndex)]
    }
}
//MARK:VTMagicViewDelegate
extension BSBaseSegmentedControl :VTMagicViewDelegate{
    func magicView(_ magicView: VTMagicView, viewDidAppear viewController: UIViewController, atPage pageIndex: UInt){
        
        segment.selectedSegmentIndex = Int(pageIndex)
        
    }
    
    func magicView(_ magicView: VTMagicView, didSelectItemAt itemIndex: UInt){
        
    }
    
}
//全局风格统一 指示器
class VCVTMagic:VTMagicController{
    
    override func viewDidLoad() {
        
        magicView.navigationColor       = UIColor.white
        magicView.sliderColor           = UIColor.black
        magicView.separatorColor        = UIColor(hexString: "#EAEAEA")
        magicView.layoutStyle           = .divide
        magicView.switchStyle           = .default
        magicView.navigationHeight      = 40
        magicView.sliderWidth           = 50
        
        magicView.isMenuScrollEnabled     = true
        magicView.isScrollEnabled         = true
        
    }
    
}
