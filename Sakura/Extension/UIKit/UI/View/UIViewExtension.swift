//
//  UIViewExtension.swift
//  SwiftyUI
//
//  Created by YaeSakura on 16/5/5.
//  Copyright © 2016 Sakura. All rights reserved.
//

import UIKit


// MARK: - Stored Property

public extension UIView
{
    
}

// MARK: - Common

extension UIView
{
    
    public var viewController: UIViewController? {
        var view: UIView? = self
        while view != nil {
            if (view?.next is UIViewController) {
                return (view?.next as? UIViewController)!
            }
            view = view?.superview
        }
        return nil
    }
    
    public var navigationController: UINavigationController? {
        var view: UIView? = self
        while view != nil {
            let nextResponder = view?.next
            if (nextResponder is UIViewController) {
                let viewController: UIViewController? = (nextResponder as? UIViewController)
                if viewController?.navigationController != nil {
                    return viewController?.navigationController
                }
            }
            view = view?.superview
        }
        return nil
    }
    
    public var tabBarController: UITabBarController? {
        var tabBarController: UITabBarController? = nil
        
        //Scan rootViewController.
        let rootViewContrller = UIApplication.shared.keyWindow?.rootViewController
        if (rootViewContrller is UINavigationController) {
            let controller = (rootViewContrller as? UINavigationController)
            if (controller?.topViewController is UITabBarController) {
                tabBarController = controller?.topViewController as? UITabBarController
            }
        }
        
        //Traverse all response to find tab bar controller.
        if tabBarController == nil {
            var view: UIView? = self
            while view != nil {
                if (view?.next is UITabBarController) {
                    tabBarController = (view?.next as? UITabBarController)
                }
                view = view?.superview
            }
        }
        return tabBarController!
    }
    
    /// Print all subviews recursively in the view hierarchy including self.
    public func printHierarchy() {
        
        struct Static { static var depth = 0 }
        
        for _ in 0 ..< Static.depth { print("\t", terminator: "") }
        
        let className = NSStringFromClass(type(of:self))
        let frame = NSStringFromCGRect(self.frame)
        
        print("\(className): \(frame)")
        
        Static.depth += 1
        for subview in self.subviews {
            subview.printHierarchy()
        }
        Static.depth -= 1

    }
    
}

