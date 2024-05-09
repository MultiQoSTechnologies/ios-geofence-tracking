//
//  ExtensionsUIView.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension of UIView For giving the round shape to any UIView.
extension UIView {
    
    @IBInspectable fileprivate var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            if newValue == (self.CViewWidth/2) {
                self.layer.cornerRadius = newValue

            } else {
                self.layer.cornerRadius = newValue.aspectRatio
            }
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable fileprivate var borderColor: UIColor? {
        get {
            guard let borderColor = self.layer.borderColor else { return nil }
            return UIColor(cgColor: borderColor)
        } set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable fileprivate var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    
    /// This method is used to giving the round shape to any UIView
    func roundView() {
        
        layer.cornerRadius = CViewHeight > CViewWidth
            ? CViewWidth/2.0
            : CViewHeight/2.0
        
        layer.masksToBounds = true
    }

}

// MARK: - Extension of UIView For getting any UIView from XIB.
extension UIView {
    
    /// This static Computed property is used to getting any UIView from XIB. This Computed property returns UIView? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("UIView!") then application will crash.
    static var viewFromXib: UIView? {
        return self.viewWithNibName(strViewName: "\(self)")
    }
    
    /// This static method is used to getting any UIView with specific name.
    ///
    /// - Parameter strViewName: A String Value of UIView.
    /// - Returns: This Method returns UIView? , it means this method return nil value also , while using this method please use if let. If you are not using if let and if this method returns nil and when you are trying to unwrapped this value("UIView!") then application will crash.
    static func viewWithNibName(strViewName: String) -> UIView? {
        
        guard let view = Bundle.MainBundle.loadNibNamed(
            strViewName,
            owner: self,
            options: nil)?.first as? UIView else {
                return nil
        }
        
        return view
    }
}

// MARK: - Extension of UIView For removing all the subviews of UIView.
extension UIView {
    
    /// This method is used for removing all the subviews of UIView.
    func removeAllSubviews() {
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    /// This method is used for removing all the subviews from InterfaceBuilder for perticular tag.
    /// - Parameter tag: Pass the tag value of UIView , and that UIView and its all subviews will remove from InterfaceBuilder.
    func removeAllSubviewsOfTag(tag: Int) {
        
        for subview in self.subviews where subview.tag == tag {
            subview.removeFromSuperview()
        }
    }
}

// MARK: - Extension of UIView For draw a shadowView of it.
extension UIView {
    
    /// This method is used to draw a shadowView for perticular UIView.
    ///
    /// - Parameters:
    ///   - color: Pass the UIColor that you want to see as shadowColor.
    ///   - shadowOffset: Pass the CGSize value for how much far you want shadowView from parentView.
    ///   - shadowRadius: Pass the CGFloat value for how much length(Blur Spreadness) you want in shadowView.
    func shadow(
        color: UIColor,
        shadowOffset: CGSize,
        shadowRadius: CGFloat
    ) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIDevice.mainScreen.scale
    }
}

// MARK: - Extension of UIView For adding the border to UIView at any position.
extension UIView {
    
    /// A Enum UIPosition Describes the Different Postions.
    ///
    /// - top: Will add border at top of The UIView.
    /// - left: Will add border at left of The UIView.
    /// - bottom: Will add border at bottom of The UIView.
    /// - right: Will add border at right of The UIView.
    enum UIPosition {
        case top
        case left
        case bottom
        case right
    }
    
    /// This method is used to add the border to perticular UIView at any position.
    ///
    /// - Parameters:
    ///   - position: Pass the enum value of UIPosition , according to the enum value it will add the border for that position.
    ///   - color: Pass the UIColor which you want to see in a border.
    ///   - width: CGFloat value - (Optional - if you are passing nil then method will automatically set this value same as Parent's width) OR pass how much width you want for border. For top and bottom UIPosition you can pass nil.
    ///   - height: CGFloat value - (Optional - if you are passing nil then method will automatically set this value same as Parent's height) OR pass how much height you want for border. For left and right UIPosition you can pass nil.
    func addBorder(
        position: UIPosition = .top,
        color: UIColor = .black,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        
        let borderLayer = CALayer()
        borderLayer.backgroundColor = color.cgColor
        
        var xPosition: CGFloat = 0.0
        var yPosition: CGFloat = 0.0
        var layerWidth: CGFloat = width ?? 1.0
        var layerHeight: CGFloat = height ?? 1.0
        
        switch position {
            
        case .top:
            layerWidth = width ?? CViewWidth
            
        case .left:
            layerHeight = height ?? CViewHeight
            
        case .bottom:
            yPosition = CViewHeight - (height ?? 0.0)
            layerWidth = width ?? CViewWidth
            
        case .right:
            xPosition = CViewWidth - (width ?? 0.0)
            layerHeight = height ?? CViewHeight
        }
        
        borderLayer.frame = CGRect(
            origin: CGPoint(
                x: xPosition,
                y: yPosition
            ),
            size: CGSize(
                width: layerWidth,
                height: layerHeight
            )
        )
        
        self.layer.addSublayer(borderLayer)
    }
    
    /// To add the same border on multiple positions.
    /// Pass the positions into array which side wants to show the border.
    /// example:- [.top, .left, .bottom, .right]
    func addBorder(
        positions: [UIPosition] = [.top],
        color: UIColor = .black,
        width: CGFloat? = nil,
        height: CGFloat? = nil) {
        
        for position in positions {
            
            addBorder(
                position: position,
                color: color,
                width: width,
                height: height
            )
        }
        
    }
}

typealias tapInsideViewHandler = (() -> ())

extension UIView {
    
    private struct AssociatedObjectKey {
        static var tapInsideViewHandler = "tapInsideViewHandler"
    }
    
    func tapInsideViewHandler(tapInsideViewHandler: @escaping tapInsideViewHandler) {
        
        self.isUserInteractionEnabled = true
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.tapInsideViewHandler,
            tapInsideViewHandler,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        guard let tapGesture = self.gestureRecognizers?.first(where: {$0.isEqual(UITapGestureRecognizer.self)}) as? UITapGestureRecognizer else {
            
            self.addGestureRecognizer(UITapGestureRecognizer(
                target: self,
                action: #selector(handleTapGesture(sender:)))
            )
            
            return
        }
        
        tapGesture.addTarget(
            self,
            action: #selector(handleTapGesture(sender:))
        )
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        
        if let tapInsideViewHandler = objc_getAssociatedObject(self, &AssociatedObjectKey.tapInsideViewHandler) as? tapInsideViewHandler {
            tapInsideViewHandler()
        }
    }
}

extension UIView {
    
    var snapshotImage: UIImage? {
        
        var snapShotImage: UIImage?
        
        UIGraphicsBeginImageContext(self.CViewSize)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                snapShotImage = image
            }
        }
        return snapShotImage
    }
}

extension UIView {
    
    var CViewSize: CGSize {
        return self.frame.size
    }
    var CViewOrigin: CGPoint {
        return self.frame.origin
    }
    var CViewWidth: CGFloat {
        return self.CViewSize.width
    }
    var CViewHeight: CGFloat {
        return self.CViewSize.height
    }
    var CViewX: CGFloat {
        return self.CViewOrigin.x
    }
    var CViewY: CGFloat {
        return self.CViewOrigin.y
    }
    var CViewCenter: CGPoint {
        return CGPoint(x: self.CViewWidth/2.0, y: self.CViewHeight/2.0)
    }
    var CViewCenterX: CGFloat {
        return CViewCenter.x
    }
    var CViewCenterY: CGFloat {
        return CViewCenter.y
    }
}

extension UIView {
    
    func CViewSetSize(width: CGFloat, height: CGFloat) {
        CViewSetWidth(width: width)
        CViewSetHeight(height: height)
    }
    
    func CViewSetOrigin(x: CGFloat, y: CGFloat) {
        CViewSetX(x: x)
        CViewSetY(y: y)
    }
    
    func CViewSetWidth(width: CGFloat) {
        self.frame.size.width = width
    }
    
    func CViewSetHeight(height: CGFloat) {
        self.frame.size.height = height
    }
    
    func CViewSetX(x: CGFloat) {
        self.frame.origin.x = x
    }
    
    func CViewSetY(y: CGFloat) {
        self.frame.origin.y = y
    }
    
    func CViewSetCenter(x: CGFloat, y: CGFloat) {
        CViewSetCenterX(x: x)
        CViewSetCenterY(y: y)
    }
    
    func CViewSetCenterX(x: CGFloat) {
        self.center.x = x
    }
    
    func CViewSetCenterY(y: CGFloat) {
        self.center.y = y
    }
}

extension UIView {
    
    func alternateCorners(_ corners: CACornerMask, radius: CGFloat) {
        
        if #available(iOS 11, *) {
            
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
            
        } else {
            
            var cornerMask = UIRectCorner()
            
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            
            self.layer.mask = mask
        }
    }
}

extension UIView {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
