//
//  Array+.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/10/20.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
extension Array {
    //MARK:  转换 为 SectionModel 以组划分
    func transSectionModelArray() -> [SectionModel<String,Element>] {
        
        let arr = self.map { SectionModel.init(model: "", items: [$0] )}
        return arr
        
    }
}
