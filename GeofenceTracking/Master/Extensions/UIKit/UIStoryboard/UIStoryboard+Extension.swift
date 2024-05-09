//
//  UIStoryboard+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instanceFrom<T:UIViewController>(controller:T.Type) -> T?{
        let indentifier = "\((controller as UIViewController.Type))"
        return self.instantiateViewController(withIdentifier: indentifier) as? T
    }
}
