//
//  UIImageExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/13.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage
{
    public convenience init(color: UIColor) {
        self.init(color: color, size: CGSize(width: 1, height: 1))
    }
    
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: size))
            if let image = UIGraphicsGetImageFromCurrentImageContext()?.cgImage {
                self.init(cgImage: image)
            } else { self.init() }
        } else { self.init() }
        UIGraphicsEndImageContext()
    }
    
//    public convenience init(gradientType: GradientType, size: CGSize) {
//        switch gradientType {
//        case .linear(let colors, let loactions, let startPoint, let endPoint):
//            break
//        default:
//            break
//        }
//
//        self.init()
//    }
    
    public func resized(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func cropped(_ rect: CGRect) -> UIImage? {
        if rect.contains(CGRect(origin: .zero, size: self.size)) {
            return self
        }
        if let image = self.cgImage?.cropping(to: rect) {
            return UIImage(cgImage: image)
        }
        return nil
    }
    
    
    /// Get color at a pixel.
    ///
    /// - Parameter point: Pixel coord.
    /// - Returns: Color in that pixel.
    public func getColor(atPixel point: CGPoint) -> UIColor? {
        if !CGRect(origin: .zero, size: self.size).contains(point) { return nil }
        
        var color: UIColor? = nil
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let rgba = calloc(4, MemoryLayout<CUnsignedChar>.size)
        if let context = CGContext(data: rgba, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue) {
            context.setBlendMode(.copy)
            context.translateBy(x: -point.x, y: point.y - self.size.height)
            if let cgimage = self.cgImage {
                context.draw(cgimage, in: CGRect(origin: .zero, size: self.size))
                if let pointer = rgba?.assumingMemoryBound(to: CUnsignedChar.self) {
                    let red   = CGFloat(*pointer) / 255.0
                    let green = CGFloat(*(pointer + 1)) / 255.0
                    let blue  = CGFloat(*(pointer + 2)) / 255.0
                    let alpha = CGFloat(*(pointer + 3)) / 255.0
                    color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
                }
            }
        }
        free(rgba)
        
        return color
    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - rect: <#rect description#>
    ///   - samplingRate: <#samplingRate description#>
    /// - Returns: <#return value description#>
//    public func getAverageColor(inRect rect: CGRect, samplingRate: Float = 1) -> UIColor? {
//        return nil
//    }
}


//extension UIImage
//{
//    public enum GradientType
//    {
//        case linear(colors: [UIColor], loactions: [Float], startPoint: CGPoint, endPoint: CGPoint)
//        case bilinear(colors: [UIColor], colors2: [UIColor], loactions: [Float], loactions2: [Float], startPoint: CGPoint, endPoint: CGPoint, startPoint2: CGPoint, endPoint2: CGPoint)
//        case radial
//        case conical(colors: [UIColor], loactions: [Float], startAngle: Float, endAngle: Float)
//        case reflected
//        case diamond
//    }
//}

