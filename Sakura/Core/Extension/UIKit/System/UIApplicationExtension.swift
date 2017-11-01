//
//  UIApplicationExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2016/12/5.
//  Copyright © 2016 Sakura. All rights reserved.
//

import Foundation

public extension UIApplication
{
    
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
    public static var documentDirectory: String { return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! }
    
    
    /// Jump to system page.
    ///
    /// - Parameter to: Where to go.
    public func jump(to: ApplicationJumpType) {
        switch to {
        case .call(let to):
            jump(url: "tel://\(to)")
        case .mail(let to):
            jump(url: "mailto://\(to)")
        case .safari(let url):
            jump(url: url)
        case .sms(let pn):
            jump(url: "sms://\(pn)")
        case .setting(let type):
            switch type {
            case .appSetting: jump(url: UIApplicationOpenSettingsURLString)
            case .notifications: jump(url: type.rawValue + "&&path=\(bundleID)")
            default: jump(url: type.rawValue)
            }
        }
    }
    
    /// Open application with url.
    ///
    /// - Parameter url: Jump URL.
    public func jump(url: String) {
        if  let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlString) {
            if self.canOpenURL(url) {
                self.openURL(url)
            }
        }
    }
    
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
 
    
    /// <#Description#>
    ///
    /// - safari: <#safari description#>
    /// - setting: <#setting description#>
    /// - telephone: <#telephone description#>
    /// - messages: <#messages description#>
    /// - mail: <#mail description#>
    public enum ApplicationJumpType {
        case call(Int)
        case mail(String)
        case safari(String)
        case setting(SettingJumpType)
        case sms(Int)
        
        public enum SettingJumpType: String {
            case root = "App-prefs:settings"                                //Setting
            case wifi = "App-prefs:root=WIFI"                               //Setting - Wifi
            case bluetooth = "App-Prefs:root=Bluetooth"                     //Setting - Bluetooth
            case mobileData = "App-Prefs:root=MOBILE_DATA_SETTINGS_ID"      //Setting - Mobile data
            case carrier = "App-prefs:root=Carrier"                         //Setting - Carrier
            case doNotDisturb = "App-prefs:root=DO_NOT_DISTURB"             //Setting - Do Not Disturb
            case general = "App-prefs:root=General"                         //Setting - General
            case display = "App-prefs:root=DISPLAY&BRIGHTNESS"              //Setting - Display & Brightness
            case wallpaper = "App-prefs:root=Wallpaper"                     //Setting - Wallpaper
            case sounds = "App-prefs:root=Sounds"                           //Setting - Sound
            case siri = "App-prefs:root=SIRI"                               //Setting - Siri
            case battery = "App-prefs:root=BATTERY_USAGE"                   //Setting - Battery
            case privacy = "App-prefs:root=Privacy"                         //Setting - Privacy
            case phone = "App-prefs:root=Phone"                             //Setting - Phone 
            case icloud = "App-prefs:root=CASTLE"                           //Setting - iCloud
            case store = "App-prefs:root=STORE"                             //Setting - Store
            case safari = "App-prefs:root=SAFARI"                           //Setting - Setting
            case music = "App-prefs:root=MUSIC"                             //Setting - Music
            case notes = "App-prefs:root=NOTES"                             //Setting - Notes
            case twitter = "App-prefs:root=TWITTER"                         //Setting - Twitter
            case facebook = "App-prefs:root=FACEBOOK"                       //Setting - Facebook
            case photos = "App-prefs:root=Photos"

            case date = "App-prefs:root=General&path=DATE_AND_TIME"                 //Setting - General - Date
            case keyboard = "App-prefs:root=General&path=Keyboard"                  //Setting - General - Keyboard
            case language = "App-prefs:root=General&path=Language_AND_Region"       //Setting - General - Language
            case vpn = "App-prefs:root=General&path=VPN"                            //Setting - General - VPN
            case profiles = "App-prefs:root=General&path=ManagedConfigurationList"  //Setting - General - Profiles & Device Manager
            
            //case reset = "App-prefs:root=General&path=Reset"
            //case about = "App-prefs:root=General&path=About"
            //case softwareUpdateLink = "App-prefs:root=General&path=SOFTWARE_UPDATE_LINK"
            //case accessibility = "App-prefs:root=General&path=ACCESSIBILITY"
            //case storage = "App-prefs:root=CASTLE&path=STORAGE_AND_BACKUP"

            case appSetting = "app-settings:"                           //App setting
            case notifications = "App-prefs:root=NOTIFICATIONS_ID"      //App notification (Setting - Notification - Self)
        }
    }
}

@objc public enum LaunchImageOrientation: Int {
    case portrait
    case landscape
}
