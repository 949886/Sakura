//
//  UIApplicationExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2016/12/5.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

@objc public enum LaunchImageOrientation: Int {
    case portrait
    case landscape
}

public extension UIApplication {
    
    /// Application infomation.
    
    public var bundleName : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String }
    public var bundleID : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String }
    public var version : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String }
    public var buildVersion : String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String }
    
    
    /// Directories
    
    public static var homeDirectory: String { return NSHomeDirectory() }
    public static var tmpDirectory: String { return NSTemporaryDirectory() }
    public static var libraryDirectory: String { return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! }
    public static var cacheDirectory: String { return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! }
    
    
    /// Get launch image from Assets or LaunchScreen.stroyboard.
    ///
    /// - Parameter forOrientation: Portrait or landspace.
    /// - Returns: Launch screen image for specific orientation.
    public func launchImage(forOrientation orientation: LaunchImageOrientation) -> UIImage? {
        
        //Get launch image from assets.
        let launchImages = Bundle.main.infoDictionary?["UILaunchImages"] as? [[String:String]]
        var viewOrientation = "";
        switch (orientation) {
        case .portrait: viewOrientation = "Portrait"
        case .landscape: viewOrientation = "Landscape"
        }
        for info in launchImages ?? [] {
            var imageSize = CGSizeFromString(info["UILaunchImageSize"] ?? "{0,0}")
            if viewOrientation == info["UILaunchImageOrientation"] {
                if info["UILaunchImageOrientation"] == "Landscape" {
                    imageSize = CGSize(width: imageSize.height, height: imageSize.width)
                }
                if imageSize == UIScreen.main.bounds.size {
                    return UIImage(named: info["UILaunchImageName"] ?? "")
                }
            }
        }
        
        //Get launch image from LaunchScreen.stroyboard.
        if launchImages == nil || launchImages?.count == 0 {
            let stroryboardName = Bundle.main.infoDictionary?["UILaunchStoryboardName"] as? String ?? ""
            let controller = UIStoryboard(name: stroryboardName, bundle: nil).instantiateInitialViewController()
            controller?.view.frame = UIScreen.main.bounds
            
            UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, UIScreen.main.scale)
            if let context = UIGraphicsGetCurrentContext() {
                controller?.view.layer.render(in: context)
            }
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        
        return nil
    }
}
