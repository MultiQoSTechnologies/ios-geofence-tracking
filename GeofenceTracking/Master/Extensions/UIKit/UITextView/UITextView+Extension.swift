//
//  UITextView+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit


extension UITextView {
    
    var trimmed: String {
        return self.text.trim
    }
    
    @IBInspectable var doneAccessory : Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard() {
        
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIDevice.screenWidth, height: 50))
        doneToolbar.barStyle = self.keyboardAppearance == .dark ? .blackTranslucent : .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        if self.keyboardAppearance == .dark {
            done.tintColor = .white
            doneToolbar.tintColor = .black
        }
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
    
    func leftSpace() {
        self.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
}
