//
//  UIImageExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/13.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage
{
    public var centerStretchableImage : UIImage? {
        return self.stretchableImage(withLeftCapWidth: Int(self.size.width * 0.5), topCapHeight: Int(self.size.height * 0.5))
    }
    
    public func getColor(atPixel point: CGPoint) -> UIColor? {
        if !CGRect(origin: .zero, size: self.size).contains(point) {
            return nil
        }
        
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
//        var rgba = calloc(4, <#T##__size: Int##Int#>)
        
//        let context = CGContext(data: <#T##UnsafeMutableRawPointer?#>, width: <#T##Int#>, height: <#T##Int#>, bitsPerComponent: <#T##Int#>, bytesPerRow: <#T##Int#>, space: <#T##CGColorSpace#>, bitmapInfo: <#T##UInt32#>)
        
        return nil
    }
}
