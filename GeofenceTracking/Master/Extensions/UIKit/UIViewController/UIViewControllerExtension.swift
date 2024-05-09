//
//  UIViewController+Extension.swift
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MessageUI
import SafariServices

typealias alertActionHandler = ((UIAlertAction) -> ())?
typealias alertTextFieldHandler = ((UITextField) -> ())

typealias popUpCompletionHandler = (() -> ())

extension UIViewController {
    
    private struct AssociatedObjectKeyForPopUp {
        static var popUpOverlay = "popUpOverlay"
    }
    
    var popUpOverlay: PopUpOverlay? {
        if let popUpOverlay = objc_getAssociatedObject(self, &AssociatedObjectKeyForPopUp.popUpOverlay) as? PopUpOverlay {
            return popUpOverlay
        } else {
            guard let popUpOverlay = PopUpOverlay.shared else { return nil }
            popUpOverlay.imgVBlur.frame = UIDevice.mainScreen.bounds
            
            objc_setAssociatedObject(self, &AssociatedObjectKeyForPopUp.popUpOverlay, popUpOverlay, .OBJC_ASSOCIATION_RETAIN)
            return popUpOverlay
        }
    }
    
    func presentPopUp(view: UIView, shouldOutSideClick: Bool, isBlurOverlay: Bool, type: PopUpOverlay.PopUpPresentType, completionHandler: popUpCompletionHandler?) {
        
        guard let popUpOverlay = self.popUpOverlay else { return }
        var blurImage: UIImage?
        
        if isBlurOverlay {
            
            if self.navigationController != nil {
                blurImage = self.navigationController?.view.snapshotImage?.blurImage(radius: 5.0)
                self.navigationController?.view.addSubview(popUpOverlay)
            } else {
                blurImage = self.view.snapshotImage?.blurImage(radius: 5.0)
                self.view.addSubview(popUpOverlay)
            }
            popUpOverlay.imgVBlur.image = blurImage
            
        } else {
            
            if self.navigationController != nil {
                self.navigationController?.view.addSubview(popUpOverlay)
            } else {
                self.view.addSubview(popUpOverlay)
            }
        }
        
        popUpOverlay.shouldOutSideClick = shouldOutSideClick
        popUpOverlay.type = type
        popUpOverlay.addSubview(view)
        
        popUpOverlay.presentPopUpOverlayView(view: view, completionHandler: completionHandler)
    }
    
    func dismissPopUp(view: UIView, completionHandler: popUpCompletionHandler?) {
        guard let popUpOverlay = self.popUpOverlay else { return }
        popUpOverlay.dismissPopUpOverlayView(view: view, completionHandler: completionHandler)
    }
}

typealias blockHandler = ((_ data: Any?, _ error: String?) -> ())

// MARK: - Extension of UIViewController set the Block and getting back with some data(Any Type of Data) AND error message(String).
extension UIViewController {
    
    /// This Private Structure is used to create all AssociatedObjectKey which will be used within this extension.
    private struct blockKey {
        static var blockHandler = "blockHandler"
    }
    
    /// A Computed Property (only getter) of blockHandler(data , error) , Both data AND error are optional so you can pass nil if you don't want to share anything. This Computed Property is optional , it might be return nil so please use if let OR guard let.
    var block: blockHandler? {
        guard let block = objc_getAssociatedObject(self, &blockKey.blockHandler) as? blockHandler else { return nil }
        return block
    }
    
    /// This method is used to set the block on CurrentController for getting back with some data(Any Type of Data) AND error message(String).
    ///
    /// - Parameter block: This block contain data(Any Type of Data) AND error message(String) to let you help in CurrentController. Both data AND error might be nil , in this case to prevent the crash please use if let OR guard let.
    func setBlock(block: @escaping blockHandler) {
        objc_setAssociatedObject(self, &blockKey.blockHandler, block, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

// MARK: - Extension of UIViewController.
extension UIViewController {
    
    /// This static method is used for initialize the UIViewController with nibName AND bundle.
    /// - Returns: This Method returns instance of UIViewController.
    static func initWithNibName() -> Self {
        return self.init(nibName: "\(self)", bundle: nil)
    }
    
    var isVisible: Bool {
        return self.isViewLoaded && (self.view.window != nil)
    }
    
    var isPresentted: Bool {
        return self.isBeingPresented || self.isMovingToParent
    }
    
    var isDismissed: Bool {
        return self.isBeingDismissed || self.isMovingFromParent
    }
}

extension UIViewController {
    
    func openInSafari(strUrl: String) {
        
        if let url = strUrl.toURL {
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        } else {
            AppLogs.debugPrint("Master Log ::--> Unable to Convert the String to URL")
        }
    }
    
    func openSafariViewController(strUrl: String) {
        if let url = strUrl.toURL {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
}

extension UIViewController : MFMailComposeViewControllerDelegate {
    
    func openMailComposer(subject: String, toRecipients: [String]?, ccRecipients: [String]?, bccRecipients: [String]?, body: String, isHTML: Bool) {
        
        let mfMailComposeViewController = MFMailComposeViewController()
        mfMailComposeViewController.mailComposeDelegate = self
        
        mfMailComposeViewController.setSubject(subject)
        mfMailComposeViewController.setToRecipients(toRecipients)
        mfMailComposeViewController.setCcRecipients(ccRecipients)
        mfMailComposeViewController.setBccRecipients(bccRecipients)
        mfMailComposeViewController.setMessageBody(body, isHTML: isHTML)
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mfMailComposeViewController, animated: true, completion: nil)
        }
    }
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}


