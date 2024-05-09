//
//  UIViewController+ActionSheet.swift
//  SetupApp
//
//  Created by mac-0005 on 08/01/20.
//  Copyright © 2020 mac-00020. All rights reserved.
//

import Foundation
import UIKit
/*
// MARK: - Extension of UIViewController For Actionsheet with Different Numbers of Buttons -
extension UIViewController {
    
    /// This Method is used to show ActionSheet with One Button and with One(by Default) "Cancel Button" , While Using this method you don't need to add "Cancel Button" as its already there in ActionSheet.
    ///
    /// - Parameters:
    ///   - actionSheetTitle: A String value that indicates the title of ActionSheet , it is Optional so you can pass nil if you don't want ActionSheet Title.
    ///   - actionSheetMessage: A String value that indicates the ActionSheet message.
    
    ///   - btnOneTitle: A String value - Title of button one.
    ///   - btnOneStyle: A Enum value of "UIAlertActionStyle" , don't pass .cancel as it is already there in ActionSheet(By Default) , If you are passing this value as .cancel then application will crash
    ///   - btnOneTapped: Button One Tapped Handler (Optional - you can pass nil if you don't want any action).
    func presentActionsheetWithOneButton(actionSheetTitle: String?, actionSheetMessage: String?, btnOneTitle: String, btnOneStyle: UIAlertAction.Style, btnOneTapped: alertActionHandler) {
        
        let alertController = UIAlertController(title: actionSheetTitle, message: actionSheetMessage, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: btnOneStyle, handler: btnOneTapped))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// This Method is used to show ActionSheet with Two Buttons and with One(by Default) "Cancel Button" , While Using this method you don't need to add "Cancel Button" as its already there in ActionSheet.
    ///
    /// - Parameters:
    ///   - actionSheetTitle: A String value that indicates the title of ActionSheet , it is Optional so you can pass nil if you don't want ActionSheet Title.
    ///   - actionSheetMessage: A String value that indicates the ActionSheet message.
    ///   - btnOneTitle: A String value - Title of button one.
    ///   - btnOneStyle: A Enum value of "UIAlertActionStyle" , don't pass .cancel as it is already there in ActionSheet(By Default) , If you are passing this value as .cancel then application will crash
    ///   - btnOneTapped: Button One Tapped Handler (Optional - you can pass nil if you don't want any action).
    ///   - btnTwoTitle: A String value - Title of button two.
    ///   - btnTwoStyle: A Enum value of "UIAlertActionStyle" , don't pass .cancel as it is already there in ActionSheet(By Default) , If you are passing this value as .cancel then application will crash
    ///   - btnTwoTapped: Button Two Tapped Handler (Optional - you can pass nil if you don't want any action).
    @discardableResult func presentActionsheetWithTwoButtons(actionSheetTitle: String?, actionSheetMessage: String?, btnOneTitle: String, btnOneStyle: UIAlertAction.Style, btnOneTapped: alertActionHandler, btnTwoTitle: String, btnTwoStyle: UIAlertAction.Style, btnTwoTapped: alertActionHandler) -> UIAlertController {
        
        let alertController = UIAlertController(title: actionSheetTitle, message: actionSheetMessage, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: btnOneStyle, handler: btnOneTapped))
        alertController.addAction(UIAlertAction(title: btnTwoTitle, style: btnTwoStyle, handler: btnTwoTapped))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    /// This Method is used to show ActionSheet with Three Buttons and with One(by Default) "Cancel Button" , While Using this method you don't need to add "Cancel Button" as its already there in ActionSheet.
    ///
    /// - Parameters:
    ///   - actionSheetTitle: A String value that indicates the title of ActionSheet , it is Optional so you can pass nil if you don't want ActionSheet Title.
    ///   - actionSheetMessage: A String value that indicates the ActionSheet message.
    ///   - btnOneTitle: A String value - Title of button one.
    ///   - btnOneStyle: A Enum value of "UIAlertActionStyle" , don't pass .cancel as it is already there in ActionSheet(By Default) , If you are passing this value as .cancel then application will crash
    ///   - btnOneTapped: Button One Tapped Handler (Optional - you can pass nil if you don't want any action).
    ///   - btnTwoTitle: A String value - Title of button two.
    ///   - btnTwoStyle: A Enum value of "UIAlertActionStyle" , don't pass .cancel as it is already there in ActionSheet(By Default) , If you are passing this value as .cancel then application will crash
    ///   - btnTwoTapped: Button Two Tapped Handler (Optional - you can pass nil if you don't want any action).
    ///   - btnThreeTitle: A String value - Title of button three.
    ///   - btnThreeStyle: A Enum value of "UIAlertActionStyle" , don't pass .cancel as it is already there in ActionSheet(By Default) , If you are passing this value as .cancel then application will crash
    ///   - btnThreeTapped: Button Three Tapped Handler (Optional - you can pass nil if you don't want any action).
    func presentActionsheetWithThreeButton(actionSheetTitle: String?, actionSheetMessage: String?, btnOneTitle: String, btnOneStyle: UIAlertAction.Style, btnOneTapped: alertActionHandler, btnTwoTitle: String, btnTwoStyle: UIAlertAction.Style, btnTwoTapped: alertActionHandler, btnThreeTitle: String, btnThreeStyle: UIAlertAction.Style, btnThreeTapped: alertActionHandler) {
        
        let alertController = UIAlertController(title: actionSheetTitle, message: actionSheetMessage, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: btnOneStyle, handler: btnOneTapped))
        alertController.addAction(UIAlertAction(title: btnTwoTitle, style: btnTwoStyle, handler: btnTwoTapped))
        alertController.addAction(UIAlertAction(title: btnThreeTitle, style: btnThreeStyle, handler: btnThreeTapped))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}*/
