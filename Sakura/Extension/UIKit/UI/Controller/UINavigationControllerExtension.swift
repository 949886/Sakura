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
    
    open func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    @discardableResult
    open func popViewController(animated: Bool, completion: @escaping ()->()) -> UIViewController? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controller = self.popViewController(animated: animated)
        CATransaction.commit()
        return controller
    }
    
    @discardableResult
    open func popToViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping ()->()) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controllers = self.popToViewController(viewController, animated: animated)
        CATransaction.commit()
        return controllers
    }
    
    @discardableResult
    open func popToRootViewController(animated: Bool, completion: @escaping ()->()) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let controllers = self.popToRootViewController(animated: animated)
        CATransaction.commit()
        return controllers
    }
}
