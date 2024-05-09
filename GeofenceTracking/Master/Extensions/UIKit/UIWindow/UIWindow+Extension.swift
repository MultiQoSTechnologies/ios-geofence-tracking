//
//  UIWindow+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    func visibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = self.rootViewController {
            return UIWindow.getVisibleViewControllerFrom(vc: rootViewController)
        }
        return nil
    }
    
    class func getVisibleViewControllerFrom(vc: UIViewController) -> UIViewController {
        
        if vc.isKind(of: UINavigationController.self) {
            if let navigationController = vc as? UINavigationController {
                return UIWindow.getVisibleViewControllerFrom(vc: navigationController.visibleViewController ?? UIViewController())
            }
            
        } else if vc.isKind(of: UITabBarController.self) {
            
            if let tabBarController = vc as? UITabBarController {
                return UIWindow.getVisibleViewControllerFrom(vc: tabBarController.selectedViewController ?? UIViewController())
            }
            
        } else {
            if let presentedViewController = vc.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: presentedViewController)
            } else {
                return vc
            }
        }
        return UIViewController()
    }
}
