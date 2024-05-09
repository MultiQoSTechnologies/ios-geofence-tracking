//
//  UIButton+Extension.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

typealias genericTouchUpInsideHandler<T> = ((T) -> ())

// MARK: - Extension of UIButton For TouchUpInside Handler.
extension UIButton {
    
    /// This Private Structure is used to create all AssociatedObjectKey which will be used within this extension.
    private struct AssociatedObjectKey {
        static var genericTouchUpInsideHandler = "genericTouchUpInsideHandler"
    }
    
    /// This method is used for UIButton's touchUpInside Handler
    /// - Parameter genericTouchUpInsideHandler: genericTouchUpInsideHandler will give you object of UIButton.
    func touchUpInside(genericTouchUpInsideHandler: @escaping genericTouchUpInsideHandler<UIButton>) {
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.genericTouchUpInsideHandler,
            genericTouchUpInsideHandler,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        self.addTarget(
            self,
            action: #selector(handleButtonTouchEvent(sender:)),
            for: .touchUpInside
        )
        
    }
    
    /// This Private method is used for handle the touch event of UIButton.
    ///
    /// - Parameter sender: UIButton.
    @objc private func handleButtonTouchEvent(sender: UIButton) {
        
        if let genericTouchUpInsideHandler = objc_getAssociatedObject(self, &AssociatedObjectKey.genericTouchUpInsideHandler) as?  genericTouchUpInsideHandler<UIButton> {
            genericTouchUpInsideHandler(sender)
        }
    }
}

// MARK: - Extension of UIButton For getting the IndexPath of UIButton that's exist on UITableView.
extension UIButton {
    
    /// This method is used For getting the IndexPath of UIButton that's exist on UITableView.
    ///
    /// - Parameter tableView: A UITableView.
    /// - Returns: This Method returns IndexPath? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("IndexPath!") then application will crash.
    func toIndexPath(tableView: UITableView) -> IndexPath? {
        
        return tableView.indexPathForRow(
            at: convert(
                CGPoint.zero,
                to: tableView
            )
        )
        
    }
}

extension UIButton {
    
    func setNormalTitle(normalTitle: String?) {
        setTitle(
            normalTitle,
            for: .normal
        )
    }
    
    func setSelectedTitle(selectedTitle: String?) {
        setTitle(
            selectedTitle,
            for: .selected
        )
    }
    
    func setHighLightedTitle(highLightedTitle: String?) {
        setTitle(
            highLightedTitle,
            for: .highlighted
        )
    }
    
    func setTitles(
        normalTitle: String? = nil,
        selectedTitle: String? = nil,
        highLightedTitle: String? = nil
    ) {
        self.setNormalTitle(normalTitle: normalTitle)
        self.setSelectedTitle(selectedTitle: selectedTitle)
        self.setHighLightedTitle(highLightedTitle: highLightedTitle)
    }
    
}

extension UIButton {
    
    func setNormalImage(normalImgName: String) {
        setImage(
            UIImage(named: normalImgName),
            for: .normal
        )
    }
    
    func setSelectedImage(selectedImgName: String) {
        setImage(
            UIImage(named: selectedImgName),
            for: .selected
        )
    }
    
    func setHighLightedImage(highLightedImgName: String) {
        setImage(
            UIImage(named: highLightedImgName),
            for: .highlighted
        )
    }
    
    func setImages(
        normalImgName: String? = nil,
        selectedImgName: String? = nil,
        highLightedImgName: String? = nil
    ) {
        
        if let image = normalImgName {
            setNormalImage(normalImgName: image)
        }
        
        if let image = selectedImgName {
            setSelectedImage(selectedImgName: image)
        }
        
        if let image = highLightedImgName {
            setHighLightedImage(highLightedImgName: image)
        }
    }
}

extension UIButton {
    
    func setNormalTitleColor(color: UIColor?) {
        setTitleColor(
            color,
            for: .normal
        )
    }
    
    func setSelectedTitleColor(color: UIColor?) {
        setTitleColor(
            color,
            for: .selected
        )
    }
    
    func setHighLightedTitleColor(color: UIColor?) {
        setTitleColor(
            color,
            for: .highlighted
        )
    }
    
    func setTitleColors(normalColor: UIColor? = nil, selectedColor: UIColor? = nil, highLightedColor: UIColor? = nil) {
        
        setNormalTitleColor(color: normalColor)
        setSelectedTitleColor(color: selectedColor)
        setHighLightedTitleColor(color: highLightedColor)
    }
}

