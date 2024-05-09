//
//  ApplicationConstants.swift
// 
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit
 
//MARK:- Common Constant
let CGCDMainThread = DispatchQueue.main
let CGCDBackgroundThread = DispatchQueue.global(qos: .background)

class AppConstants {
    
    static let gcdMainThread = DispatchQueue.main
    static let gcdBackgroundThread = DispatchQueue.global(qos: .background)

    static var pageLimit: Int {
        return 30
    }
    
}
