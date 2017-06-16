//
//  NSObjectExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/24.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation
import ObjectiveC

extension NSObject
{
    //MARK: Associated Objects
    
    public func setAssociatedObject(key: String, value: Any?) {
        self.associatedObjects[key] = value
    }
    
    public func getAssociatedObject(key: String) -> Any? {
        return self.associatedObjects[key] ?? nil
    }
    
    private struct AssociatedKey {
        static var associatedObjects: Void?
    }
    
    private var associatedObjects: [String:Any?] {
        get { return _getAssociatedObjects() }
        set { _setAssociatedObjects(newValue) }
    }
    
    private func _getAssociatedObjects() -> [String:Any?] {
        return objc_getAssociatedObject(self, &AssociatedKey.associatedObjects) as? [String:Any?] ?? [:]
    }
    
    private func _setAssociatedObjects(_ objects: [String:Any?]) {
        objc_setAssociatedObject(self, &AssociatedKey.associatedObjects, objects, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    //Mark: Swizzle
    
    
    /// Exchange IMP of original method & swizzled method.
    ///
    /// - Parameters:
    ///   - originalSelector: Selector of original method.
    ///   - swizzledSelector: Selector of swizzled method.
    public static func swizzle(_ originalSelector: Selector, _ swizzledSelector: Selector) {
        DispatchQueue.once(token: "\(self.self)\(originalSelector)\(swizzledSelector)", block: {
            let clazz = self.self
            
            let originalMethod = class_getInstanceMethod(clazz, originalSelector)
            let swizzledMethod = class_getInstanceMethod(clazz, swizzledSelector)
            
            if class_addMethod(clazz, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)) {
                class_replaceMethod(clazz, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else { method_exchangeImplementations(originalMethod, swizzledMethod) }
        })
    }
    
    //MARK: Misc
    
    
    /// Print all ivars of a nsobject.
    public static func printIvars() {
        
        var outCount: UInt32 = 0
        let ivars = class_copyIvarList(self.self, &outCount);
        for i in 0...Int(outCount) {
            if let ivar = ivars?.advanced(by: i).pointee {
                print("Name: \(String(cString: ivar_getName(ivar))), " +
                    "Type: \(String(cString: ivar_getTypeEncoding(ivar)))")
            }
        }
        free(ivars)
        
        if let superclass = self.superclass() {
            superclass.printIvars()
        }
    }
    
}
