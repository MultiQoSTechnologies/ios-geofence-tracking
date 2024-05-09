//
//  UINavigationController+Extension.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension of UINavigationController For assigning the RootViewController of UINavigationController.
extension UINavigationController {
    
    /// This static method is used For assigning the RootViewController of UINavigationController.
    ///
    /// - Parameter viewController: Pass the UIViewController's instance for set it as RootViewController of UINavigationController.
    /// - Returns: RootViewController of UINavigationController.
    static func rootViewController(viewController: UIViewController) -> UINavigationController {
        
        return self.init(rootViewController: viewController)
    }
    
    /// This method is used to getting back to any UIViewController among UIViewController's Stack.
    ///
    /// - Parameters:
    ///   - viewController: Pass the UIViewController's instance for which you want to get back.
    ///   - animated: A Bool Value for Animated OR Not.
    func popToViewController(viewController: UIViewController, animated: Bool = true) {
        
        for vc in self.viewControllers where vc.isKind(of: viewController.classForCoder) {
            self.popToViewController(vc, animated: animated)
        }
    }
    
    /// This method is used to check the presented ViewController.
    ///
    /// - Parameters:
    ///   - viewController: Pass the UIViewController's instance for which you want to check.
    static func hasPresented(viewController: UIViewController) -> Bool {
        
        let presentingIsModal = viewController.presentingViewController != nil
        
        let presentingIsNavigation = viewController.navigationController?.presentingViewController?.presentedViewController == viewController.navigationController
        
        let presentingIsTabBar = viewController.tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    
}
