//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.

import Foundation
import UIKit

class AppLoader {
    
    private init() {}
    
    private static let appLoader: AppLoader = {
        let appLoader = AppLoader()
        return appLoader
    }()
    
    static var shared: AppLoader {
        return appLoader
    }
    
    var isAnimating: Bool = false
    fileprivate var type: AppLoaderType = .activityIndicator
    
    fileprivate static var circularLineWidth = 3.0
    fileprivate static var animationDuration = 1.5
}

extension AppLoader {
    
    enum AppLoaderType {
        case activityIndicator
        case activityIndicatorWithMessage
        case circularRing
        case animatedGIF
    }
}

extension AppLoader {
    
    fileprivate static let transparentOverlayView: UIView = {
        
        let transparentOverlayView = UIView()
        transparentOverlayView.frame = UIDevice.mainScreen.bounds
        transparentOverlayView.backgroundColor = UIColor.rgbToColor(r: 0, g: 0, b: 0, a: 0.6)
        return transparentOverlayView
    }()
    
    func setTransparentOverlayViewBgColor(bgColor: UIColor?) {
        AppLoader.transparentOverlayView.backgroundColor = bgColor
    }
    
    func setTransparentOverlayViewAlpha(alpha: CGFloat) {
        
        if var rgba = AppLoader.transparentOverlayView.backgroundColor?.getRGB() {
            
            rgba.a = alpha
            
            AppLoader.transparentOverlayView.backgroundColor = UIColor.rgbToColor(r: rgba.r * 255.0, g: rgba.g * 255.0, b: rgba.b * 255.0, a: rgba.a)
        }
    }
}

extension AppLoader {
    
    fileprivate static let containView: UIView = {
        
        let containView = UIView()
        containView.backgroundColor = .clear
        containView.layer.cornerRadius = 10.0
        containView.translatesAutoresizingMaskIntoConstraints = false
        return containView
    }()
    
    func setContainViewCornerRadius(cornerRadius: CGFloat) {
        AppLoader.containView.layer.cornerRadius = cornerRadius
    }
    
    func setContainViewBgColor(bgColor: UIColor?) {
        AppLoader.containView.backgroundColor = bgColor
    }
    
    func setContainViewAlpha(alpha: CGFloat) {
        
        if var rgba = AppLoader.containView.backgroundColor?.getRGB() {
            
            rgba.a = alpha
            
            AppLoader.containView.backgroundColor = UIColor.rgbToColor(r: rgba.r * 255.0, g: rgba.g * 255.0, b: rgba.b * 255.0, a: rgba.a)
        }
    }
}

extension AppLoader {
    
    fileprivate static let activityIndicator: UIActivityIndicatorView = {
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .lightGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    func setActivityIndicatorStyle(style: UIActivityIndicatorView.Style) {
        AppLoader.activityIndicator.style = style
    }
    
    func setActivityIndicatorColor(color: UIColor?) {
        AppLoader.activityIndicator.color = color
    }
    
    func setActivityIndicatorTintColor(tintColor: UIColor) {
        AppLoader.activityIndicator.tintColor = tintColor
    }
    
    func setActivityIndicatorBgColor(bgColor: UIColor?) {
        AppLoader.activityIndicator.backgroundColor = bgColor
    }
}

extension AppLoader {
    
    fileprivate static let lblMessage: UILabel = {
        
        let lblMessage = UILabel()
        lblMessage.textAlignment = .center
        lblMessage.textColor = .white
        lblMessage.backgroundColor = .clear
        lblMessage.translatesAutoresizingMaskIntoConstraints = false
        return lblMessage
    }()
    
    func setLblMessageTextAlignment(alignment: NSTextAlignment) {
        AppLoader.lblMessage.textAlignment = alignment
    }
    
    func setLblMessageFont(font: UIFont) {
        AppLoader.lblMessage.font = font
    }
    
    func setLblMessageTextColor(textColor: UIColor) {
        AppLoader.lblMessage.textColor = textColor
    }
    
    fileprivate func setLblMessageText(message: String?) {
        AppLoader.lblMessage.text = message
    }
}

extension AppLoader {
    
    fileprivate static let circularView: UIView = {
        
        let circularView = UIView()
        circularView.backgroundColor = .clear
        
        circularView.layer.addSublayer(AppLoader.firstLayer)
        circularView.layer.addSublayer(AppLoader.secondLayer)
        
        circularView.translatesAutoresizingMaskIntoConstraints = false
        
        return circularView
    }()
    
    fileprivate static let firstLayer: CAShapeLayer = {
        
        let firstLayer = CAShapeLayer()
        firstLayer.frame = UIDevice.mainScreen.bounds
        firstLayer.strokeColor = UIColor.white.cgColor
        firstLayer.fillColor = nil
        firstLayer.lineWidth = CGFloat(AppLoader.circularLineWidth)
        return firstLayer
    }()
    
    fileprivate static let secondLayer: CAShapeLayer = {
        
        let secondLayer = CAShapeLayer()
        secondLayer.frame = UIDevice.mainScreen.bounds
        secondLayer.strokeColor = UIColor.white.cgColor
        secondLayer.fillColor = nil
        secondLayer.lineWidth = CGFloat(AppLoader.circularLineWidth)
        return secondLayer
    }()
    
    fileprivate static let rotationAnimation: CAAnimation = {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = 2.0 * .pi
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.duration = AppLoader.animationDuration
        return rotationAnimation
    }()
    
    func setCircularRingBorderColor(color: UIColor?) {
        AppLoader.firstLayer.strokeColor = color?.cgColor
        AppLoader.secondLayer.strokeColor = color?.cgColor
    }
    
    func setCircularRingLineWidth(lineWidth: Double) {
        AppLoader.circularLineWidth = lineWidth
    }
    
    func setCircularRingAnimationDuration(duration: Double) {
        AppLoader.animationDuration = duration
    }
}

extension AppLoader {
    
    fileprivate static let gifImgView: UIImageView = {
        let gifImgView = UIImageView()
        gifImgView.backgroundColor = .clear
        gifImgView.translatesAutoresizingMaskIntoConstraints = false
        return gifImgView
    }()
}

extension AppLoader {
    
    fileprivate func startAnimating() {
        AppLoader.shared.isAnimating = true
        AppLoader.activityIndicator.startAnimating()
    }
    
    fileprivate func stopAnimating() {
        AppLoader.shared.isAnimating = false
        AppLoader.activityIndicator.stopAnimating()
        AppLoader.activityIndicator.removeFromSuperview()
    }
}

extension AppLoader {
    
    fileprivate func showActivityIndicator(viewController: UIViewController?) {
        viewController?.view.addSubview(AppLoader.activityIndicator)
        self.resizeActivityIndicator(viewController: viewController)
        self.startAnimating()
    }
    
    private func resizeActivityIndicator(viewController: UIViewController?) {
        
        NSLayoutConstraint(item: AppLoader.activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: viewController?.view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive  = true
        
        NSLayoutConstraint(item: AppLoader.activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: viewController?.view, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive  = true
    }
    
    fileprivate func hideActivityIndicator() {
        self.stopAnimating()
    }
}

extension AppLoader {
    
    fileprivate func showActivityIndicatorWithMessage(viewController: UIViewController?, message: String?) {
        
        AppLoader.shared.setLblMessageText(message: message)
        
        viewController?.view.addSubview(AppLoader.transparentOverlayView)
        AppLoader.transparentOverlayView.addSubview(AppLoader.containView)
        AppLoader.containView.addSubview(AppLoader.activityIndicator)
        AppLoader.containView.addSubview(AppLoader.lblMessage)
        
        self.resizeActivityIndicatorWithMessage()
        self.startAnimating()
    }
    
    private func resizeActivityIndicatorWithMessage() {
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .centerX, relatedBy: .equal, toItem: AppLoader.transparentOverlayView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .centerY, relatedBy: .equal, toItem: AppLoader.transparentOverlayView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: AppLoader.containView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        let topOfActivityIndicator = NSLayoutConstraint(item: AppLoader.activityIndicator, attribute: .top, relatedBy: .equal, toItem: AppLoader.containView, attribute: .top, multiplier: 1.0, constant: 25.0)
        
        topOfActivityIndicator.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue((AppLoader.lblMessage.text != nil) ? 1000 : 750))
        topOfActivityIndicator.isActive = true
        
        let leadingOfActivityIndicator = NSLayoutConstraint(item: AppLoader.activityIndicator, attribute: .leading, relatedBy: .equal, toItem: AppLoader.containView, attribute: .leading, multiplier: 1.0, constant: 25.0)
        
        leadingOfActivityIndicator.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue((AppLoader.lblMessage.text != nil) ? 750 : 1000))
        leadingOfActivityIndicator.isActive = true
        
        let CenterYOfActivityIndicator = NSLayoutConstraint(item: AppLoader.activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: AppLoader.containView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        CenterYOfActivityIndicator.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue((AppLoader.lblMessage.text != nil) ? 750 : 1000))
        CenterYOfActivityIndicator.isActive = true
        
        AppLoader.activityIndicator.layoutIfNeeded()
        
        NSLayoutConstraint(item: AppLoader.lblMessage, attribute: .centerX, relatedBy: .equal, toItem: AppLoader.containView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        let topOfLblMessage =  NSLayoutConstraint(item: AppLoader.lblMessage, attribute: .top, relatedBy: .equal, toItem: AppLoader.activityIndicator, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        
        topOfLblMessage.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue((AppLoader.lblMessage.text != nil) ? 1000 : 750))
        topOfLblMessage.isActive = true
        
        let leadingOfLblMessage =  NSLayoutConstraint(item: AppLoader.lblMessage, attribute: .leading, relatedBy: .equal, toItem: AppLoader.containView, attribute: .leading, multiplier: 1.0, constant: 15.0)
        
        leadingOfLblMessage.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue((AppLoader.lblMessage.text != nil) ? 1000 : 750))
        leadingOfLblMessage.isActive = true
        
        let bottomOfLblMessage =  NSLayoutConstraint(item: AppLoader.lblMessage, attribute: .bottom, relatedBy: .equal, toItem: AppLoader.containView, attribute: .bottom, multiplier: 1.0, constant: -15.0)
        
        bottomOfLblMessage.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue((AppLoader.lblMessage.text != nil) ? 1000 : 749))
        bottomOfLblMessage.isActive = true
        
        AppLoader.lblMessage.layoutIfNeeded()
    }
    
    fileprivate func hideActivityIndicatorWithMessage() {
        self.stopAnimating()
        AppLoader.transparentOverlayView.removeAllSubviews()
        AppLoader.transparentOverlayView.removeFromSuperview()
    }
}

extension AppLoader {
    
    fileprivate func showCircularRing(viewController: UIViewController?) {
        
        viewController?.view.addSubview(AppLoader.transparentOverlayView)
        AppLoader.transparentOverlayView.addSubview(AppLoader.containView)
        AppLoader.containView.addSubview(AppLoader.circularView)
        
        self.resizeCircularRing()
        self.startCircularRingAnimation()
    }
    
    private func resizeCircularRing() {
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .centerX, relatedBy: .equal, toItem: AppLoader.transparentOverlayView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .centerY, relatedBy: .equal, toItem: AppLoader.transparentOverlayView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0).isActive = true
        
        AppLoader.containView.layoutIfNeeded()
        
        if let gradientLayer = AppLoader.containView.layer.sublayers?.filter({$0 is CAGradientLayer}).first as? CAGradientLayer {
            
            gradientLayer.cornerRadius = 4.0
        }
        
        NSLayoutConstraint(item: AppLoader.circularView, attribute: .centerX, relatedBy: .equal, toItem: AppLoader.containView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.circularView, attribute: .centerY, relatedBy: .equal, toItem: AppLoader.containView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.circularView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.circularView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        
        AppLoader.circularView.layoutIfNeeded()
    }
    
    private func startCircularRingAnimation() {
        
        let radius = (min(AppLoader.circularView.CViewWidth, AppLoader.circularView.CViewHeight)/2.0) - (CGFloat((AppLoader.circularLineWidth/2.0)))
        
        AppLoader.firstLayer.path = UIBezierPath(arcCenter: AppLoader.circularView.CViewCenter, radius: radius, startAngle: -1.25, endAngle: 1.25, clockwise: true).cgPath
        
        AppLoader.secondLayer.path = UIBezierPath(arcCenter: AppLoader.circularView.CViewCenter, radius: radius, startAngle: 1.89, endAngle: 4.39, clockwise: true).cgPath
        
        CGCDMainThread.async {
            
            AppLoader.circularView.layer.add(AppLoader.rotationAnimation, forKey: "rotationAnimation")
            AppLoader.shared.isAnimating = true
        }
    }
    
    fileprivate func hideCircularRing() {
        AppLoader.circularView.layer.removeAnimation(forKey: "rotationAnimation")
        AppLoader.shared.isAnimating = false
        AppLoader.transparentOverlayView.removeAllSubviews()
        AppLoader.transparentOverlayView.removeFromSuperview()
    }
}

extension AppLoader {
    
    
    fileprivate func showGifLoader(viewController: UIViewController?) {
        
        viewController?.view.addSubview(AppLoader.transparentOverlayView)
        AppLoader.transparentOverlayView.addSubview(AppLoader.containView)
        AppLoader.containView.addSubview(AppLoader.gifImgView)
        
        self.resizeGifLoader()
        AppLoader.shared.isAnimating = true
    }
    
    private func resizeGifLoader() {
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .centerX, relatedBy: .equal, toItem: AppLoader.transparentOverlayView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .centerY, relatedBy: .equal, toItem: AppLoader.transparentOverlayView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.containView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0).isActive = true
        
        AppLoader.containView.layoutIfNeeded()
        
        NSLayoutConstraint(item: AppLoader.gifImgView, attribute: .centerX, relatedBy: .equal, toItem: AppLoader.containView, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.gifImgView, attribute: .centerY, relatedBy: .equal, toItem: AppLoader.containView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.gifImgView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        
        NSLayoutConstraint(item: AppLoader.gifImgView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0).isActive = true
        
        AppLoader.gifImgView.layoutIfNeeded()
    }
    
    fileprivate func hideGifLoader() {
        AppLoader.shared.isAnimating = false
        AppLoader.transparentOverlayView.removeAllSubviews()
        AppLoader.transparentOverlayView.removeFromSuperview()
    }
}

extension AppLoader {
    
    func showLoader(viewController: UIViewController?, type: AppLoaderType, message: String?) {
        
        AppLoader.shared.type = type
        
        switch type {
            
        case .activityIndicator:
            self.showActivityIndicator(viewController: viewController)
            
        case .activityIndicatorWithMessage:
            self.showActivityIndicatorWithMessage(viewController: viewController, message: message)
            
        case .circularRing:
            self.showCircularRing(viewController: viewController)
            
        case .animatedGIF:
            self.showGifLoader(viewController: viewController)
        }
    }
    
    func hideLoader() {
        
        switch AppLoader.shared.type {
            
        case .activityIndicator:
            self.hideActivityIndicator()
            
        case .activityIndicatorWithMessage:
            self.hideActivityIndicatorWithMessage()
            
        case .circularRing:
            self.hideCircularRing()
            
        case .animatedGIF:
            self.hideGifLoader()
            
        }
    }
}
