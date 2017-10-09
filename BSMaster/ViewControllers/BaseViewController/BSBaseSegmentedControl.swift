//
//  BSBaseSegmentedControl.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/30.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import UIKit
import VTMagic
enum SegmentStyle {
    case headerView  // 顶部有Title View
    case none        // 顶部无Title View
}

/*-- 顶部 segment 视图  内容为 Controllers 基类--*/
class BSBaseSegmentedControl: BSBaseViewController {
    
    var controllerArray     : [UIViewController] = []  // 存放controller 的array
    var segmentStyle : SegmentStyle? {
        didSet {
            switch segmentStyle ?? .none {
            case .headerView:
                configHeaderView()
                break
            default:
                hiddenHeaderView()
                break
            }
        }
    
    }
    
    var selectCurrentIndex  : Int? = 0
    
    var v                   : VCVTMagic!
    
    var titleSegmentArray :Array<String> = [] { // 顶部导航栏segment title 数组，
        didSet{
            configSegmentNavition()  // 配置顶部导航View
        }
    }
    
    var titleVCSegmentArray :Array<String> = [] // 顶部segment title 数组，
   
    var segment :UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configMagicView()
    }
    //MARK:配置顶部 segment
    func configSegmentNavition()  {
        segment             = UISegmentedControl.init(items: titleSegmentArray)
        segment.frame.size  = CGSize.init(width: 180, height: 20)
        segment.addSelectorAction {[unowned self] (selectorIndex) in
            
            self.v.magicView.switch(toPage: UInt (selectorIndex), animated: true)
            
        }
        self.navigationItem.titleView = segment
    }
    //MARK:配置所对应的左右滑动ViewControler
    func configMagicView()  {
        v                                       = VCVTMagic()
        v.magicView.dataSource                  = self
        v.magicView.delegate                    = self

        self.addChildViewController(v)
        self.view.addSubview(v.magicView)
        v.magicView.snp.makeConstraints {[weak self] (make) -> Void in
            if let strongSelf = self {
                make.size.equalTo(strongSelf.view)
                
            }
        }
//
    }
    //MARK: 隐藏顶部Title View  只保留 VC 数组
    func hiddenHeaderView()  {
        v.magicView.navigationView.isHidden     = true
        v.magicView.navigationHeight            = 0
    }
    //MARK: 展示 顶部 Title View
    func configHeaderView()  {
        v.magicView.layoutStyle         = .divide
        v.magicView.switchStyle         = .default
        v.magicView.sliderWidth         = 50
        v.magicView.itemWidth           = MGScreenWidth / 2
        v.magicView.sliderColor         = UIColor.black
        v.magicView.sliderHeight        = 3
        v.magicView.isSeparatorHidden   = true
        v.magicView.isSwitchAnimated    =  false
    }
    //MARK: 更新整个界面的UI 展示界面元素
    func updateUI()  {
        v.magicView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
//MARK:VTMagicViewDataSource
extension BSBaseSegmentedControl:VTMagicViewDataSource{
    var identifier_magic_view_bar_item : String {
        get {
            return "identifier_magic_view_bar_item"
        }
    }
    var identifier_magic_view_page : String {
        get {
            return "identifier_magic_view_page"
        }
    }
    func menuTitles(for magicView: VTMagicView) -> [String] {
        
        switch segmentStyle ?? .none {
        case .headerView:
              return titleVCSegmentArray
        case .none:
              return titleSegmentArray

        }
       
    }
    func magicView(_ magicView: VTMagicView, menuItemAt itemIndex: UInt) -> UIButton{
        let button = magicView .dequeueReusableItem(withIdentifier: self.identifier_magic_view_bar_item)
        
        if ( button == nil) {
            let width           = self.view.frame.width / 3
            let b               = UIButton(type: .custom)
            b.frame             = CGRect(x: 0, y: 0, width: width, height: 50)
            b.titleLabel!.font  =  UIFont.systemFont(ofSize: 14)
            b.setTitleColor(UIColor.gray, for: UIControlState())
            b.setTitleColor(UIColor.black, for: .selected)
            b.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            
            return b
        }
        
        return button!
    }
    func buttonAction(){
//        DLog("button")
    }
    func magicView(_ magicView: VTMagicView, viewControllerAtPage pageIndex: UInt) -> UIViewController{
        return controllerArray[Int(pageIndex)]
    }
}
//MARK:VTMagicViewDelegate
extension BSBaseSegmentedControl :VTMagicViewDelegate{
    func magicView(_ magicView: VTMagicView, viewDidAppear viewController: UIViewController, atPage pageIndex: UInt){
        
        switch segmentStyle ?? .none {
        case .headerView:
           break
        case .none: // 更新顶部segment位置
           segment.selectedSegmentIndex = Int(pageIndex)
            
        }
       
        
    }
    
    func magicView(_ magicView: VTMagicView, didSelectItemAt itemIndex: UInt){
        
    }
    
}
//全局风格统一 指示器
class VCVTMagic:VTMagicController{
    
    override func viewDidLoad() {
        
        magicView.navigationColor           = UIColor.white
        magicView.sliderColor               = UIColor.black
        magicView.separatorColor            = UIColor(hexString: "#EAEAEA")
        magicView.layoutStyle               = .divide
        magicView.switchStyle               = .default
        magicView.navigationHeight          = 40
        magicView.sliderWidth               = 50
        magicView.isMenuScrollEnabled       = true
        magicView.isScrollEnabled           = true
        
    }
    
}
