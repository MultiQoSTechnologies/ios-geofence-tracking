//
//  UIControl+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021..
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

class ClosureSleeve {
    let closure: (UIControl)->()
    
    init (_ closure: @escaping (UIControl)->()) {
        self.closure = closure
    }
    
    @objc func invoke (_ sender: UIControl) {
        closure(sender)
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping (UIControl)->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke(_:)), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
