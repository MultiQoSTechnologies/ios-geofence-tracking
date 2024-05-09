//
//  UIColor+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        
        var _hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        if _hexString.hasPrefix("#") {
            _hexString = String(_hexString.dropFirst())
        }
        let scanner = Scanner(string: _hexString)
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let mask = 0x000000FF
        let r = Int(rgbValue >> 16) & mask
        let g = Int(rgbValue >> 8) & mask
        let b = Int(rgbValue) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
