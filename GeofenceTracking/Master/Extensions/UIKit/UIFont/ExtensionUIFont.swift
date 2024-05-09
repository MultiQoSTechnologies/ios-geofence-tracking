//
//  ExtensionUIFont.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021.All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    func setUpAppropriateFont() -> UIFont? {
        
        if UIDevice.isIPhone5 {
            return UIFont(name: self.fontName, size: self.pointSize - 3.0)
        } else if UIDevice.isIPhone6Plus || UIDevice.isIPhoneXR {
            return UIFont(name: self.fontName, size: self.pointSize + 2.0)
        } else {
            return UIFont(name: self.fontName, size: self.pointSize)
        }
    }
}
