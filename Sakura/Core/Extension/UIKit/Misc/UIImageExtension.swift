//
//  UIImageExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/13.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation
import CoreGraphics

//MARK: - Common

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
    
    /// Get color at a pixel.
    ///
    /// - Parameter point: Pixel coord.
    /// - Returns: Color in that pixel.
    public func getColor(at point: CGPoint) -> UIColor? {
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
    public func getAverageColor(in rect: CGRect) -> UIColor? {
        if rect.width * rect.height > Int.max.f ||
           rect == .zero {
            return nil
        }
        
        var color: UIColor?
        
        if  let image = self.cropped(rect),
            let cgimage = image.cgImage {
            
            let width = Int(image.size.width)
            let height = Int(image.size.height)
            let pixelsCount = width * height
            
            let rgba = calloc(4 * pixelsCount, sizeof(CUnsignedChar.self))
            
            if  let context = CGContext.init(data: rgba, width: width, height: height),
                let pointer = rgba?.assumingMemoryBound(to: CUnsignedChar.self) {
                context.draw(cgimage, in: CGRect(origin: .zero, size: image.size))
                
                var cumulativeRed = 0.0
                var cumulativeGreen = 0.0
                var cumulativeBlue = 0.0
                var cumulativeAlpha = 0.0
                
                for i in 0...pixelsCount * 4 {
                    let red   = Double(pointer[i * 4]) / 255.0;
                    let green = Double(pointer[i * 4 + 1]) / 255.0;
                    let blue  = Double(pointer[i * 4 + 2]) / 255.0;
                    let alpha = Double(pointer[i * 4 + 3]) / 255.0;
                    
                    cumulativeRed += alpha == 0 ? red : 1.0;
                    cumulativeGreen += alpha == 0 ? green : 1.0;
                    cumulativeBlue += alpha == 0 ? blue : 1.0;
                    cumulativeAlpha += alpha;
                }
                
                color = UIColor(red: cumulativeRed.f / pixelsCount.f,
                                green: cumulativeGreen.f / pixelsCount.f,
                                blue: cumulativeBlue.f / pixelsCount.f,
                                alpha: cumulativeAlpha.f / pixelsCount.f)
            }
            
            free(rgba)
        }
        
        return color
    }
    
    public func getAverageColor(at point: CGRect, withRadius radius: CGFloat) -> UIColor? {
        return nil
    }
}

//MARK: - Modify

extension UIImage
{
    
    func modify(hue:Int, saturation: Int, brightness: Int) -> UIImage? {
        return nil
    }
    
    /// <#Description#>
    ///
    /// - Parameter size: <#size description#>
    /// - Returns: <#return value description#>
    public func resized(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// <#Description#>
    ///
    /// - Parameter rect: <#rect description#>
    /// - Returns: <#return value description#>
    public func cropped(_ rect: CGRect) -> UIImage? {
        if rect.contains(CGRect(origin: .zero, size: self.size)) {
            return self
        }
        if let image = self.cgImage?.cropping(to: rect) {
            return UIImage(cgImage: image)
        }
        return nil
    }
    
    /// Get a compressed image with a specific size.
    /// If original size of image is less than this size, image won't be compressed.
    ///
    /// - Parameter size: Compressed size (Unit: KB).
    public func compressed(to size: CGFloat) -> UIImage? {
        if let byteCount = UIImagePNGRepresentation(self)?.count {
            let originalSize = byteCount.f / 1024
            if size < originalSize {
                if let data = UIImageJPEGRepresentation(self, size / originalSize.f) {
                    return UIImage(data: data)
                }
                return nil
            }
        }
        return self
    }
    
    public func compressed(quality: CGFloat) -> UIImage? {
        if let data = UIImageJPEGRepresentation(self, quality) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func flipped(_ type: FlipType) -> UIImage? {
        return nil
    }
    
    func rotated(angle: Double, closewise: Bool = true) -> UIImage? {
        return nil
    }
    
    func monochrome() -> UIImage? {
        return nil
    }
    
    enum FlipType {
        case horizontal
        case vertical
    }
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
//
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
//}

