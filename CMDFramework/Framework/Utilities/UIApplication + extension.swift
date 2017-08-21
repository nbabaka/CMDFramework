//
//  UIApplication + extension.swift
//  CinemoodApp
//
//  Created by Nikolay Karataev aka Babaka on 03.04.17.
//  Copyright © 2017 Cinemood. All rights reserved.
//

public extension UIApplication {
    public static func isDebugMode() -> Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    public var screenShot: UIImage?  {
        if let rootViewController = keyWindow?.rootViewController {
            let scale = UIScreen.main.scale
            let bounds = rootViewController.view.bounds
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
            if let context = UIGraphicsGetCurrentContext() {
                //rootViewController.view.drawHierarchy(in: bounds, afterScreenUpdates: true)
                rootViewController.view.layer.render(in: context)
                let screenshot = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return screenshot
            }
        }
        return nil
    }
    
    public class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return topViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
    
    public var topViewController: UIViewController?{
        if keyWindow?.rootViewController == nil{
            return keyWindow?.rootViewController
        }
        
        var pointedViewController = keyWindow?.rootViewController
        
        while  pointedViewController?.presentedViewController != nil {
            switch pointedViewController?.presentedViewController {
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
        
    }
}

public extension Bundle {
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
