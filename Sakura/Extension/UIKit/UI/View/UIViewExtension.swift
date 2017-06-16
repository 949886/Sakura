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
    
    //MARK: Coordinates
    
    public var x: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    public var y: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    
    public var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    
    public var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }

    
    //MARK: Controllers
    
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
        return tabBarController
    }
    
    //MARK: Misc
    
    public var extraHitInsets: UIEdgeInsets? {
        get { return getAssociatedObject(key: "extraHitInsets") as? UIEdgeInsets }
        set { setAssociatedObject(key: "extraHitInsets", value: newValue) }
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

//MARK: - Swizzling

extension UIView
{
    /* Method Swizzling */
    
    open override static func initialize()  {
        swizzle(#selector(point(inside:with:)), #selector(swizzledPoint(inside:with:)))
    }

    /// The method used to exchang IMP with drawText(in:)
    func swizzledPoint(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if extraHitInsets == .zero {
            return swizzledPoint(inside: point, with: event)
        } else {
            return UIEdgeInsetsInsetRect(self.bounds, extraHitInsets ?? .zero).contains(point)
        }
    }

}
