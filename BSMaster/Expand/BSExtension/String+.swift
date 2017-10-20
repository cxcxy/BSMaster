//
//  String+.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
extension String {
    
    //将原始的url编码为合法的url  处理URL中的中文问题
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }

    var md5: String {
            let str = self.cString(using: .utf8)
            let strLen = CC_LONG(self.lengthOfBytes(using: .utf8))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
            CC_MD5(str!, strLen, result)
            let md5String = NSMutableString()
            for i in 0..<digestLen {
                md5String.appendFormat("%02x", result[i])
            }
            result.deallocate(capacity: digestLen)
            return String(format: md5String as String)
    }
    
    

}
