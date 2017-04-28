//
//  UIColorExtension.swift
//  Swifty
//
//  Created by YaeSakura on 16/5/9.
//  Copyright © 2016 Sakura. All rights reserved.
//

#if os(iOS)

import UIKit

extension UIColor
{
    public var hexString: String {
        guard let components = self.cgColor.components else { return "000000" }
        let r = components[0]
        let g = components[1]
        let b = components[2]
        return String(format: "%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
    }
    
    /// Color from hex string.
    ///
    /// - Parameter hexString: #RGB #RGBA #RRGGBB #RRGGBBAA
    public convenience init?(hexString : String) {
        var hexString = hexString.uppercased()
        
        if hexString.hasPrefix("#") {
            hexString = hexString.subString(from: 1)
        } else if hexString.hasPrefix("0X") {
            hexString = hexString.subString(from: 2)
        }
        
        if  hexString.length != 3 &&    //RGB
            hexString.length != 4 &&    //RGBA
            hexString.length != 6 &&    //RRGGBB
            hexString.length != 8 {     //RRGGBBAA
            return nil
        }
        
        if let hex = UInt(hexString, radix: 16) {
            if hexString.length == 3 {
                let r = CGFloat((hex & 0xF00) >> 8) / 255.0
                let g = CGFloat((hex & 0x0F0) >> 4) / 255.0
                let b = CGFloat(hex & 0x00F) / 255.0
                self.init(red: r, green: g, blue: b, alpha: 1.0)
            } else if hexString.length == 4 {
                let r = CGFloat((hex & 0xF000) >> 12) / 255.0
                let g = CGFloat((hex & 0x0F00) >> 8) / 255.0
                let b = CGFloat((hex & 0x00F0) >> 4) / 255.0
                let a = CGFloat(hex & 0x000F) / 255.0
                self.init(red: r, green: g, blue: b, alpha: a)
            } else if hexString.length == 6 {
                let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
                let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
                let b = CGFloat(hex & 0x0000FF) / 255.0
                self.init(red: r, green: g, blue: b, alpha: 1.0)
            } else if hexString.length == 8 {
                let r = CGFloat((hex & 0xFF000000) >> 24) / 255.0
                let g = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
                let b = CGFloat((hex & 0x0000FF00) >> 8) / 255.0
                let a = CGFloat(hex & 0x000000FF) / 255.0
                self.init(red: r, green: g, blue: b, alpha: a)
            } else { return nil }
        } else { return nil }
    }
    
    
    /// UIColor from hex unsigned int value.
    ///
    /// - Parameter hex: e.g. 0xAARRGGBB
    public convenience init(hex : UInt) {
        let a = CGFloat((hex & 0xFF000000) >> 24) / 255.0
        let r = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x0000FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x000000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

#endif
