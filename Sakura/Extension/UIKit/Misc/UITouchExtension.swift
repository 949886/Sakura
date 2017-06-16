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
    public var touchPoint: CGPoint {
        return self.location(in: self.view)
    }
    
    public var globalTouchPoint: CGPoint {
        return self.location(in: UIApplication.shared.keyWindow)
    }
    
    public var isTouchInside: Bool {
        if let view = self.view  {
            return view.bounds.contains(self.touchPoint)
        }
        return false
    }
    
}
