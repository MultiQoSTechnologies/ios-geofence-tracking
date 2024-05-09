//
//  Bundle+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation

/// While using these below properties, please use if let. If you are not using if let and if this returns nil and when you are trying to unwrapped this value then application will crash.

extension Bundle {
    
    static var MainBundle: Bundle {
        return Bundle.main
    }
    
    static var BundleIdentifier: String? {
        return MainBundle.bundleIdentifier
    }
    
    static var BundleInfoDictionary: [String: Any]? {
        return MainBundle.infoDictionary
    }
    
    static var VersionNumber: String? {
        return BundleInfoDictionary?.valueForString(key: "CFBundleShortVersionString")
    }
    
    static var BuildNumber: String? {
        return BundleInfoDictionary?.valueForString(key: "CFBundleVersion")
    }
    
    static var ApplicationName: String? {
        return BundleInfoDictionary?.valueForString(key: "CFBundleDisplayName")
    }
    
}
