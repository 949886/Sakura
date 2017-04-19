//
//  CoreGraphicExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/1/14.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension CGRect {
    
    public var x: CGFloat {
        get { return self.origin.x }
        set { self.origin.x = newValue }
    }
    
    public var y: CGFloat {
        get { return self.origin.y }
        set { self.origin.y = newValue }
    }
    
    public var width: CGFloat {
        get { return self.size.width }
        set { self.size.width = newValue }
    }
    
    public var height: CGFloat {
        get { return self.size.height }
        set { self.size.height = newValue }
    }
    
}
