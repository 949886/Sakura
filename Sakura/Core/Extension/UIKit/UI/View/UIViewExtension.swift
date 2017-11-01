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
    @objc public var extraHitInsets: UIEdgeInsets {
        get { return getAssociatedObject(key: "extraHitInsets") as? UIEdgeInsets ?? .zero }
        set { UIView.swizzling(); setAssociatedObject(key: "extraHitInsets", value: newValue) }
    }
    
//    public var cornerRadius: (CGFloat, CGFloat, CGFloat, CGFloat) {
//        get { return getAssociatedObject(key: "cornerRadius") as? (CGFloat, CGFloat, CGFloat, CGFloat) ?? (0.0, 0.0, 0.0, 0.0) }
//        set { UIView.swizzling(); setAssociatedObject(key: "cornerRadius", value: newValue) }
//    }
}

//MARK: - Layout

extension UIView
{
    
    @objc public var x: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    @objc public var y: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    
    @objc public var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    
    @objc public var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    
    @objc public var centerX: CGFloat {
        get { return self.frame.origin.x + self.frame.size.width * 0.5 }
        set { self.frame.origin.x = newValue - self.frame.size.width * 0.5 }
    }
    
    @objc public var centerY: CGFloat {
        get { return self.frame.origin.y + self.frame.size.height * 0.5 }
        set { self.frame.origin.y = newValue - self.frame.size.height * 0.5 }
    }

    @objc public var size: CGSize {
        get { return self.frame.size }
        set { self.frame = CGRect(origin: self.frame.origin, size: size) }
    }
    
    /// <#Description#>
    ///
    /// - Parameter identifier: <#identifier description#>
    /// - Returns: <#return value description#>
    @objc func getConstraint(by identifier: String?) -> NSLayoutConstraint? {
        return self.constraints.filter { $0.identifier == identifier }.first
    }
    
    /// Remove all constraints(excluding subviews).
    @objc public func clearConstraints() {
        self.removeConstraints(self.constraints)
    }
    
    /// Remove all constraints recursively.
    @objc public func clearConstraintsRecursively() {
        for subview in self.subviews {
            subview.clearConstraintsRecursively()
        }
        self.removeConstraints(self.constraints)
    }
    
    //MARK: Controllers
    
    @objc public var viewController: UIViewController? {
        var view: UIView? = self
        while view != nil {
            if (view?.next is UIViewController) {
                return (view?.next as? UIViewController)!
            }
            view = view?.superview
        }
        return nil
    }
    
    @objc public var navigationController: UINavigationController? {
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
    
    @objc public var tabBarController: UITabBarController? {
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
    
}

// MARK: - Common

extension UIView
{
    
    public func clearSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    //MARK: Visual
    
}

//MARK: - Image

extension UIView
{   	
    /// Capture a image from whole current view.
    ///
    /// - Returns: A image from current view.
    @objc public func captureImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

//MARK: - Misc

extension UIView
{
    
    /// Traverse all subviews including self.
    @objc public func traverseSubviews(_ callback: (UIView) -> Void) {
        callback(self)
        
        for subview in subviews {
            subview.traverseSubviews(callback)
        }
    }
    
    /// Print all subviews recursively in the view hierarchy including self.
    @objc public func printHierarchy() {
        
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
    
    // Swizzle methods.
    @objc static func swizzling() {
        DispatchQueue.once(token: "UIView.swizzling") {
            self.swizzle(#selector(point(inside:with:)), #selector(swizzledPoint(inside:with:)))
        }
    }
    
    /// The method used to exchang IMP with drawText(in:)
    @objc func swizzledPoint(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if extraHitInsets == .zero {
            return swizzledPoint(inside: point, with: event)
        } else {
            return UIEdgeInsetsInsetRect(self.bounds, extraHitInsets).contains(point)
        }
    }
    
}
