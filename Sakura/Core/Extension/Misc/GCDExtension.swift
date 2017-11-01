//
//  GCDExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/3/2.
//  Copyright © 2017 YaeSakura. All rights reserved.
//

import Foundation

extension DispatchQueue
{
    private static var _onceTracker = [String]()
    
    public static func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _onceTracker.contains(token) { return }
        _onceTracker.append(token)
        block()
    }
    
}
