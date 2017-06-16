//
//  UIViewControllerExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/5/22.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

@objc enum UIViewControllerTransitionAnimation : Int {
    case `default`
    case none
    case fade
}

extension UIViewController
{
    func present(_ viewControllerToPresent: UIViewController, animation: UIViewControllerTransitionAnimation, completion: (() -> Void)? = nil) {
        
    }
    
}

