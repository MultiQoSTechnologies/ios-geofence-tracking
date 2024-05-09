//
//  UITextField+Extension.swift
//  SetupApp
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

fileprivate var key: Void?

fileprivate class UITextFieldAdditions: NSObject {
    var readonly: Bool = false
}

extension UITextField {
    
    func setLeftPadding(_ _width:CGFloat) {
        
        let paddingView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: _width,
            height: self.frame.height
            )
        )
        
        self.leftView = paddingView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func setRightPadding(_ _width:CGFloat) {
        
        if _width > 0 {
            
            let paddingView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: _width,
                height: self.frame.height
            )
            )
            
            self.rightView = paddingView
            self.rightViewMode = .always
        } else {
            self.rightView = nil
        }
    }
    
    @IBInspectable var doneAccessory: Bool {
        get {
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    private func addDoneButtonOnKeyboard() {
        
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(
            x: 0,
            y: 0,
            width: UIDevice.screenWidth,
            height: 50
            )
        )
        
        doneToolbar.barStyle = self.keyboardAppearance == .dark
            ? .blackTranslucent
            : .default
        
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(self.doneButtonAction)
        )
        
        if self.keyboardAppearance == .dark {
            done.tintColor = .white
        }
        
        let items = [
            flexSpace,
            done
        ]
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc private func doneButtonAction() {
        self.resignFirstResponder()
    }
    
    var readonly: Bool {
        get {
            return self.getAdditions().readonly
        } set {
            self.getAdditions().readonly = newValue
        }
    }
    
    private func getAdditions() -> UITextFieldAdditions {
        
        var additions = objc_getAssociatedObject(self, &key) as? UITextFieldAdditions
        
        if additions == nil {
            
            additions = UITextFieldAdditions()
            objc_setAssociatedObject(
                self,
                &key,
                additions!,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
            )
        }
        return additions!
    }
    
    open override func target(forAction action: Selector, withSender sender: Any?) -> Any? {
        
        if ((action == #selector(UIResponderStandardEditActions.paste(_:)) || (action == #selector(UIResponderStandardEditActions.cut(_:)))) && self.readonly) {
            return nil
        }
        
        return super.target(
            forAction: action,
            withSender: sender
        )
    }
    
    var trimmed: String {
        get {
            return (self.text ?? "").trim
        }
    }
    
    func setupLeftImageView(img:UIImage?) {
        
        let leftImageView = UIImageView(image: img)
        leftImageView.contentMode = .scaleAspectFit
        
        let _leftView = UIView()
        _leftView.clipsToBounds = true
        _leftView.addSubview(leftImageView)
        
        leftImageView.center = _leftView.center
        _leftView.frame = CGRect(
            x: 0,
            y: 0,
            width: 30,
            height: 30
        )
        
        leftImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: 20,
            height: 20
        )
        
        self.leftViewMode = .always
        self.leftView = _leftView
    }
    
    func setupRightImageView(img:UIImage?) {
        
        let rightImageView = UIImageView(image: img)
        rightImageView.contentMode = .scaleAspectFit
        
        let _rightView = UIView()
        _rightView.clipsToBounds = true
        _rightView.addSubview(rightImageView)
        
        rightImageView.center = _rightView.center
        
        _rightView.frame = CGRect(
            x: 0,
            y: 0,
            width: 30,
            height: 30
        )
        
        rightImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: 20,
            height: 20
        )
        
        self.rightViewMode = .always
        _rightView.isUserInteractionEnabled = false
        rightImageView.isUserInteractionEnabled = false
        self.rightView?.isUserInteractionEnabled = false
        self.rightView = _rightView
    }
    
    func isValidated() -> Int {
        
        guard let _text = self.text else{
            return 1
        }
        
        if _text.trim.isEmpty {
            
            let prevPlaceholder = self.placeholderColor
            self.placeholderColor = UIColor(hexString: "#aa1a1a")
            
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 1,
                execute: {
                    self.placeholderColor = prevPlaceholder
            })
            
            self.shake()
            return 1
        }
        return 0
    }
    
    func shake() {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.autoreverses = true
        
        animation.fromValue = NSValue(cgPoint: CGPoint(
            x: self.center.x - 10,
            y: self.center.y))
        
        animation.toValue = NSValue(cgPoint: CGPoint(
            x: self.center.x + 10,
            y: self.center.y))
        
        self.layer.add(
            animation,
            forKey: "position"
        )
    }
}
