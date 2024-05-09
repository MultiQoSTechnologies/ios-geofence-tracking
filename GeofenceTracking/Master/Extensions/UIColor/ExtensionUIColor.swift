//
//  ExtensionUIColor.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
   
    static func rgbToColor(r:CGFloat , g:CGFloat , b:CGFloat, a:CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

    func getRGB() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? {
        
        var red:CGFloat = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        
        return (red , green , blue , alpha)
    }
    
    func lightColor(byPercentage: CGFloat) -> UIColor? {
        return adjustColor(byPercentage: abs(byPercentage))
    }
    
    func darkColor(byPercentage: CGFloat) -> UIColor? {
        return adjustColor(byPercentage: (-1 * abs(byPercentage)))
    }
    
    private func adjustColor(byPercentage: CGFloat) -> UIColor? {
        
        guard let RGB = self.getRGB() else { return nil }
            
        return UIColor(red: min(RGB.r + byPercentage/100.0, 1.0), green: min(RGB.g + byPercentage/100.0, 1.0), blue: min(RGB.b + byPercentage/100.0, 1.0), alpha: RGB.a)
    }
    
    func hexStringFromColor() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        
        return hexString
     }
}
