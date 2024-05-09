//
//  UIResponder+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }
}
