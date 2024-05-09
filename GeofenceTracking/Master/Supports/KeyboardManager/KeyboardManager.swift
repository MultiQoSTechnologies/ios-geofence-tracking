//
//  KeyboardManager.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

@objc protocol KeyboardManagerDelegate : class {
    
    func keyboardWillShow(notification: Notification, keyboardHeight: CGFloat)
    func keyboardWillHide(notification: Notification)
    @objc optional func keyboardWillChangeFrame(notification: Notification, keyboardHeight: CGFloat)
}

class KeyboardManager {
    
    static let shared: KeyboardManager = KeyboardManager()
    
    weak var delegate: KeyboardManagerDelegate?
    
    func enableKeyboardNotification() {
        
        NotificationCenter.default.addObserver(
            KeyboardManager.shared,
            selector: #selector(self.keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            KeyboardManager.shared,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(
            KeyboardManager.shared,
            selector: #selector(self.keyboardWillChangeFrame(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func disableKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(
            KeyboardManager.shared,
            name:  UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            KeyboardManager.shared,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            KeyboardManager.shared,
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: Notification) {
        
        guard let delegate = delegate,
            let info = notification.userInfo,
            let keyboardRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        
        delegate.keyboardWillShow(notification: notification, keyboardHeight: keyboardRect.height)
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        
        guard let delegate = delegate else {
            return
        }
        
        delegate.keyboardWillHide(notification: notification)
    }
    
    @objc
    private func keyboardWillChangeFrame(notification: Notification) {
        
        guard let delegate = delegate,
            let info = notification.userInfo,
            let keyboardRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        
        delegate.keyboardWillChangeFrame?(notification: notification, keyboardHeight: keyboardRect.height)
    }
}
