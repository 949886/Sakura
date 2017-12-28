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
    @objc public convenience init(color: UIColor) {
        self.init(color: color, size: CGSize(width: 1, height: 1))
    }
    
    @objc public convenience init(color: UIColor, size: CGSize) {
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
    @objc public func color(at point: CGPoint) -> UIColor? {
        guard let provider = self.cgImage?.dataProvider else {
            return nil
        }
        
        let data = provider.data
        let pointer: UnsafePointer<UInt8> = CFDataGetBytePtr(data)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(point.y)) + Int(point.x)) * 4
        
        let r = CGFloat(pointer[pixelInfo]) / 255.0.f
        let g = CGFloat(pointer[pixelInfo+1]) / 255.0.f
        let b = CGFloat(pointer[pixelInfo+2]) / 255.0.f
        let a = CGFloat(pointer[pixelInfo+3]) / 255.0.f
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    @objc public func averageColor() -> UIColor? {
        return averageColor(in: CGRect(origin: .zero, size: self.size))
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - rect: <#rect description#>
    ///   - samplingRate: <#samplingRate description#>
    /// - Returns: <#return value description#>
    @objc public func averageColor(in rect: CGRect) -> UIColor? {
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
            
            if pixelsCount == 0 {
                return nil
            }
            
            if let provider = cgimage.dataProvider {
                let data = provider.data
                let pointer: UnsafePointer<UInt8> = CFDataGetBytePtr(data)
                
                var cumulativeRed = 0.0
                var cumulativeGreen = 0.0
                var cumulativeBlue = 0.0
                var cumulativeAlpha = 0.0
                
                for i in 0..<pixelsCount {
                    let red   = Double(pointer[i * 4]) / 255.0;
                    let green = Double(pointer[i * 4 + 1]) / 255.0
                    let blue  = Double(pointer[i * 4 + 2]) / 255.0
                    let alpha = Double(pointer[i * 4 + 3]) / 255.0
                    
                    cumulativeRed += alpha == 0 ? 1.0 : red
                    cumulativeGreen += alpha == 0 ? 1.0 : green
                    cumulativeBlue += alpha == 0 ? 1.0 : blue
                    cumulativeAlpha += alpha
                }
                
                color = UIColor(red: cumulativeRed.f / pixelsCount.f,
                                green: cumulativeGreen.f / pixelsCount.f,
                                blue: cumulativeBlue.f / pixelsCount.f,
                                alpha: cumulativeAlpha.f / pixelsCount.f)
            }
        }
        return color
    }
    
    @objc func averageColor(at point: CGRect, withRadius radius: CGFloat) -> UIColor? {
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

//MARK: - Gradient

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
//
