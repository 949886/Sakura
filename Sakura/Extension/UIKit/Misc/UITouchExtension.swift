//
//  UITouchExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/2/28.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension UITouch
{
    var touchPoint: CGPoint {
        return self.location(in: self.view)
    }
    
    var globalTouchPoint: CGPoint {
        return self.location(in: UIApplication.shared.keyWindow)
    }
}
