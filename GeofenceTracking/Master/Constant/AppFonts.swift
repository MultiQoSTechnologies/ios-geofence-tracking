//
//  ApplicationFonts.swift
//  Tomato
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

enum FontName: String {
    case montserratRegular = "Montserrat-Regular"
    case montserratMedium = "Montserrat-Medium"
    case montserratSemiBold = "Montserrat-SemiBold"
    case montserratBold = "Montserrat-Bold"
    case montserratExtraBold = "Montserrat-ExtraBold"
}

extension UIFont {
    class func custom(name: FontName = .montserratRegular, size : CGFloat = 15.0) -> UIFont {
        
        var fontName = name.rawValue
        
        switch name {
        case .montserratRegular:
            fontName = FontName.montserratMedium.rawValue
        case .montserratMedium:
            fontName = FontName.montserratSemiBold.rawValue
        case .montserratSemiBold:
            fontName = FontName.montserratBold.rawValue
        case .montserratBold:
            fontName = FontName.montserratExtraBold.rawValue
        default:
            break
        }
        
        if let font = UIFont(name: fontName, size: size){
            return font
        }
        
        AppLogs.debugPrint("Font Not Found -> \(name.rawValue)")
        return UIFont.systemFont(ofSize: size)
    }
}

extension UIFont {
    static func printFonts() {
       for familyName in UIFont.familyNames {
           AppLogs.debugPrint("\n-- \(familyName) \n")
           for fontName in UIFont.fontNames(forFamilyName: familyName) {
               AppLogs.debugPrint(fontName)
           }
       }
    }
}


