//
//  UIImage+.swift
//  BSMaster
//
//  Created by 陈旭 on 2017/9/29.
//  Copyright © 2017年 陈旭. All rights reserved.
//

import Foundation
extension UIImage {
    
    func fixOrientation() -> UIImage {
        if (self.imageOrientation == .up) {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch (self.imageOrientation) {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
            
        default:
            break
        }
        
        switch (self.imageOrientation) {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                            bitsPerComponent: (self.cgImage?.bitsPerComponent)!, bytesPerRow: 0,
                            space: (self.cgImage?.colorSpace!)!,
                            bitmapInfo: (self.cgImage?.bitmapInfo.rawValue)!)
        ctx?.concatenate(transform)
        
        switch (self.imageOrientation) {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
            
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = ctx?.makeImage()
        return UIImage(cgImage: cgimg!)
    }
    // 根据颜色转化成图片
    class func getImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }


}
