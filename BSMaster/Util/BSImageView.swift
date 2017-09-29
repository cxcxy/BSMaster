//
//  BSImageView.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
extension UIImageView {
    //MARK: 扩展加载图片方法
    func set_Img_Url(_ url:String?)  {

        if let url = URL(string: url ?? "") {
            
            self.kf.setImage(with: url, placeholder: UIImage.init(named: ""),
                             options: [.transition(.fade(1))], progressBlock: nil,
                             completionHandler: nil)
            
        }
    }
    
}
