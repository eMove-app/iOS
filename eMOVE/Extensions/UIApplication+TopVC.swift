//
//  UIApplication+TopVC.swift
//  eMOVE
//
//  Created by Bogdan Matasaru on 08/09/2018.
//  Copyright © 2018 Bogdan Matasaru. All rights reserved.
//

import Foundation
import UIKit

@objc extension UIApplication {
    class func topViewController(controller: UIViewController? =
        UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    class func topView(controller: UIViewController? = UIApplication.topViewController()) -> UIView? {
        if let alertVC = controller as? UIAlertController {
            return alertVC.parent?.view
        }
        return controller?.view
    }
    
    class func rootViewControoler() -> UIViewController? {
        return UIApplication.shared.delegate?.window??.rootViewController ?? nil
    }
    
    class func window() -> UIWindow? {
        return UIApplication.shared.delegate?.window ?? nil
    }
}
