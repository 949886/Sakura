//
//  UINavigationControllerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/6/21.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension UINavigationController
{
    
    open func push(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    @discardableResult
    open func pop(animated: Bool = true, completion: (() -> Void)? = nil) -> UIViewController? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controller = self.popViewController(animated: animated)
        CATransaction.commit()
        return controller
    }
    
    @discardableResult
    open func pop(to viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controllers = self.popToViewController(viewController, animated: animated)
        CATransaction.commit()
        return controllers
    }
    
    @discardableResult
    open func popToRootViewController(animated: Bool = true, completion: (() -> Void)? = nil) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controllers = self.popToRootViewController(animated: animated)
        CATransaction.commit()
        return controllers
    }
    
}
