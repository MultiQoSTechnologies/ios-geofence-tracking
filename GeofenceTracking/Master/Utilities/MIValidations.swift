//
//  MIValidations.swift
//  ValidationsDemo
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Validation Enums
//MARK:-

enum ValidationOptions {
    case notEmpty, email, password, gender, dateOfBirth, mobileNumber, msgRange, matchPassword, zipcode
}

//MARK:- Validation Messages

private let charLimitForName = 50
private let minAge = 1


// Email
let CBlankEmail = "Please enter email address."
let CBlankEmailLogin = "Please enter email address." //"Please enter the registered email address."
let CInvalidEmail = "Please enter valid email address."
let CEmailNotRegister = "Entered email address is not registered with us."

// MobileNumber
let CBlankPhoneNumber = "Please enter the phone number."
let CInvalidPhoneNumber = "Please enter valid phone number."

// ChangePassword
private let CBlankOldPswd = "Please enter the old password."
let CBlankPswd = "Please enter password."
private let CInvalidPassword = "Please enter valid password."
private let CBlankNewPswd = "Please enter new password."
private let CBlankConfirmPassword = "Please enter confirm password."
private let CInvalidNewPswd = "Password must be minimum 8 character alphanumeric and must have at least one special character."
private let CMismatchPassConfirmPswd = "New password and confirm password doesn’t match."
private let CSameOldNewPswd = "New password cannot be the same as current password."
private let CSameCurrentOldPswd = "Old password must be same as current password."
let CBlankCurrentPassword = "Please enter current password."
private let CInvalidCurrentPassword = "Entered current password is incorrect."

// Message or note
private let CBlankMessage = "Please enter the message."

// Sign up
let CBlankProfilePic = "Please upload any profile image."
let CBlankGender = "Please select gender."
let CBlankDateOfBirth = "Please enter the date of birth."
private let CMinAge = "Age should be greater then required"
let CBlankFullName = "Please enter your name"
private let CBlankConfirmPswd = "Please enter confirm password."
private let CExceedNameCharacterCount = "Name should not be more then 20 characters"
let CMale = "Male"
let CFemale = "Female"
let COther = "Other"
let CInvalidZipcode = "Please enter valid zipcode."

// Constants
let COk = "Ok"


//MARK:- Validation methods
//MARK:-

struct ValidationModel {
    let validation: ValidationOptions?
    let value: Any?
    let message: String?
    let value1: Any?
}

class MIValidation {
    
    
    /// This Method Check to text is Blank or Not
    ///
    /// - Parameters:
    ///   - text: here we need to pass the text which you want to check for blank validatin
    ///   - message: here we need to pass message that you want to show in alert when that field is empty
    /// - Returns: check the validation successful
    
    private static func isNotBlank(_ text: String?, _ message: String) -> Bool {
        
        if let strText = text {
            if strText.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
        return false
    }
    
    
    /// This Method Check to Validation of Email(Blank and Valid)
    ///
    /// - Parameter text: here we need to pass the text which you want to check for email validatin
    /// - Returns: check the validation successful
    
    static func isValidEmail(_ text: String?) -> Bool {
        
        if let strEmail = text {
            
            if strEmail.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankEmail, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if !strEmail.isValidEmail {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidEmail, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankEmail, btnOneTitle: COk, btnOneTapped: nil)
        return false
    }
    
    
    /// This Method Check to Validation of Mobile Number(Blank and Valid)
    ///
    /// - Parameter text: here we need to pass the text which you want to check for email validatin
    /// - Returns: check the validation successful
    
    private static func isValidMobileNumber(_ text: String?) -> Bool {
        
        if let strMobile = text {
            
            if strMobile.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankPhoneNumber, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if !strMobile.isValidPhone {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidPhoneNumber, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankPhoneNumber, btnOneTitle: COk, btnOneTapped: nil)
        return false
    }
    
    
    /// This Method Check to Validation of Password
    ///
    /// - Parameters:
    ///   - text: here we need to pass the text which you want to check for password validation
    ///   - message: This Message show on Alert
    /// - Returns: check the validation successful
    
    private static func isValidPassword(_ text: String?, _ message: String?) -> Bool {
        
        if let strPassword = text {
            
            if strPassword.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if !strPassword.isValidPassword {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidNewPswd, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
        return false
    }
    
    /// This Method Check to Validation of Current Password
    ///
    /// - Parameters:
    ///   - text: here we need to pass the text which you want to check for password validation
    ///   - message: This Message show on Alert
    /// - Returns: check the validation successful
    
    private static func isValidCurrentPassword(_ text: String?, _ message: String?) -> Bool {
        
        if let strPassword = text {
            
            if strPassword.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if !strPassword.isValidPassword {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidCurrentPassword, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
        return false
    }
    
    
    /// This method is used to check the passwords matching and mismatching
    ///
    /// - Parameters:
    ///   - password: here we need to pass the text which you want to check for password validation
    ///   - cPassword: here we need to pass the text which you want to check for Confiorm password validation
    /// - Returns: check the validation successful
    
    private static func isMatchedPasswords(_ password: String?, _ cPassword: String?) -> Bool {
        
        if let strPassword = password, let strConfPassword = cPassword {
            
            if strPassword.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankPswd, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if !strPassword.isValidPassword {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidNewPswd, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if strConfPassword.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankConfirmPassword, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if strPassword != strConfPassword {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CMismatchPassConfirmPswd, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankPswd, btnOneTitle: COk, btnOneTapped: nil)
        return false
    }
    
    /// This method is used to check the passwords matching and mismatching
    ///
    /// - Parameters:
    ///   - password1: here we need to pass the text which you want to check for password1
    ///   - password2: here we need to pass the text which you want to check for password2
    ///   - isOldAndCurrent: here we pass to boolean for which message show on Alert
    /// - Returns: check the validation successful
    
    private static func checkPasswordsSame(_ password1: String, _ password2: String, _ isOldAndCurrent: Bool) -> Bool {
        
        if password1 != password2 {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: isOldAndCurrent ? CSameCurrentOldPswd : CMismatchPassConfirmPswd , btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        return true
    }
    
    
    /// This Function use For Change Password Validation
    ///
    /// - Parameters:
    ///   - currentPassword: here we need to pass the text which you want to check for current password validation
    ///   - oldPassword: here we need to pass the text which you want to check for old password validation
    ///   - newPassword: here we need to pass the text which you want to check for new password validation
    ///   - confirmPassword: here we need to pass the text which you want to check for confirm password validation
    /// - Returns: check the validation successful
    
    static func changePassword(currentPassword: String, _ newPassword: String, _ confirmPassword: String) -> Bool {
        
        if currentPassword.isBlank {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankCurrentPassword, btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        
        if !currentPassword.isValidPassword {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidCurrentPassword, btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        
        if !isValidPassword(newPassword, CBlankNewPswd) {
            return false
        }
        
        if currentPassword == newPassword {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CSameOldNewPswd, btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        
        if confirmPassword.isBlank {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankConfirmPswd, btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        
        if newPassword != confirmPassword {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CMismatchPassConfirmPswd, btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        
        return true
    }
    
    /// This Method check to char limit of String
    ///
    /// - Parameters:
    ///   - text: here we need to pass the text which you want to check the limit of string
    ///   - charMaxLimit: here we need to pass the value if there is any min character count
    ///   - message: here we need to pass the message that you want to show in alert
    /// - Returns: check the validation successfull
    
    private static func isMessageInRange(_ text: String?, _ charMaxLimit: Int, _ message: String) -> Bool {
        
        if let strText = text {
            
            if strText.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if strText.count > charMaxLimit {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CExceedNameCharacterCount, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankMessage, btnOneTitle: COk, btnOneTapped: nil)
        return false
    }
    
    /// This Method Check to Validation of Zipcode
    ///
    /// - Parameters:
    ///   - text: here we need to pass the text which you want to check for password validation
    ///   - message: This Message show on Alert
    /// - Returns: check the validation successful
    
    private static func isValidZipcode(_ text: String?, _ message: String?) -> Bool {
        
        if let strZipcode = text {
            
            if strZipcode.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            if !strZipcode.isValidZip {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidZipcode, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: message, btnOneTitle: COk, btnOneTapped: nil)
        return false
    }
    
    
    /// This function get to age from birthDate
    ///
    /// - Parameter birthDate: here we need to pass the text which you want to check the date
    /// - Returns: check the validation successfull
    
    private static func age(birthDate: Date?) -> Int {
        
        let now = Date()
        if let birthday = birthDate {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
            let age = ageComponents.year!
            return age
        }
        return 0
    }
    
    /// This method check to validation For Login
    ///
    /// - Parameters:
    ///   - userName: here we need to pass username
    ///   - password: here we need to pass password
    ///   - isEmailLogin: if that is not any email login then we should pass false otherwise true
    /// - Returns: check the Login successfull
    
    static func isUserCanAbleToLogin(_ userName: String, _ password: String, _ isEmailLogin: Bool = true) -> Bool {
        
        if userName.isBlank {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankEmailLogin, btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        
        if isEmailLogin {
            if !userName.isValidEmail {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidEmail, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
        }
        
        if password.isBlank {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankPswd, btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        
        if !password.isValidPassword {
            UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CInvalidPassword, btnOneTitle: COk, btnOneTapped: nil)
            return false
        }
        return true
    }
    
    /// This Function check to minAge
    ///
    /// - Parameters:
    ///   - minAge: here we need to pass min age if there is any min age validation otherwise need pass 0
    ///   - text: here we need to pass dateOfbirth string value
    ///   - date: here we need to pass dateOfbirth date value
    /// - Returns: check the Login successfull
    
    private static func isDOB(_ minimumAge: Int = minAge, text: String?, date: Date?) -> Bool {
        
        if let strText = text {
            if strText.isBlank {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankDateOfBirth, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            
            let age = MIValidation.age(birthDate: date)
            if age < minimumAge {
                UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CMinAge, btnOneTitle: COk, btnOneTapped: nil)
                return false
            }
            return true
        }
        
        UIApplication.shared.topMostVC()?.presentAlertViewWithOneButtonMIV(alertTitle: nil, alertMessage: CBlankDateOfBirth, btnOneTitle: COk, btnOneTapped: nil)
        return false
        
    }
    
    /// This Method is use for Form Validation Like SignUp
    ///
    /// - Parameter validationModel: this parameter use for pass validation model like Message, Validation Option and Value
    /// - Returns: check the Validation successfull
    
    static func isValidData(_ validationModel: [ValidationModel]) -> Bool {
        
        for validateModel in validationModel {
            
            switch validateModel.validation {
                
            case .notEmpty?:
                if !isNotBlank(validateModel.value as? String, validateModel.message ?? "") {
                    return false
                }
                continue
                
            case .msgRange?:
                if !isMessageInRange(validateModel.value as? String, charLimitForName, validateModel.message ?? "") {
                    return false
                }
                continue
                
            case .mobileNumber?:
                
                if !isValidMobileNumber(validateModel.value as? String) {
                    return false
                }
                continue
                
            case .email?:
                
                if !isValidEmail(validateModel.value as? String) {
                    return false
                }
                continue
                
            case .dateOfBirth?:
                let date = DateFormatter.sharedMIV().dateMIV(fromString: validateModel.value as? String ?? "", dateFormat: "dd MM YYYY")
                
                if !isDOB(text: validateModel.value as? String, date: date) {
                    return false
                }
                continue
            case .password?:
                
                if !isValidPassword(validateModel.value as? String, validateModel.message) {
                    return false
                }
                continue
                
            case .matchPassword?:
                
                if !isMatchedPasswords(validateModel.value as? String, validateModel.value1 as? String) {
                    return false
                }
                continue
                
            case .zipcode?:
                
                if !isValidZipcode(validateModel.value as? String, validateModel.message) {
                    return false
                }
                continue
            default:
                continue
            }
        }
        return true
    }
    
}

// MARK:- Extenstion UI ViewController
// MARK:-

extension UIViewController {
    
    typealias alertActionHandler = ((UIAlertAction) -> ())?
    
    /// This Method is used to show AlertView with one Button.
    ///
    /// - Parameters:
    ///   - alertTitle: A String value that indicates the title of AlertView , it is Optional so you can pass nil if you don't want Alert Title.
    ///   - alertMessage: A String value that indicates the title of AlertView , it is Optional so you can pass nil if you don't want alert message.
    ///   - btnOneTitle: A String value - Title of button.
    ///   - btnOneTapped: Button Tapped Handler (Optional - you can pass nil if you don't want any action).
    func presentAlertViewWithOneButtonMIV(alertTitle: String?, alertMessage: String?, btnOneTitle: String, btnOneTapped: alertActionHandler) {
        
        let alertController = UIAlertController(title: alertTitle ?? "", message: alertMessage ?? "", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: btnOneTitle, style: .default, handler: btnOneTapped))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK:- extension String
// MARK:-
extension String {
    
    var isValidPassword: Bool {
        //let passwordRegex = "^(?=.*[a-z])(?=.*[@$!%*#?&])(?=.*[0-9])[0-9a-zA-Z@$!%*#?&]{6,}"
        let passwordRegex = "^(?!.* ).{8,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with:self)
    }
    
    var isValidPhone: Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{7,}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    var isValidURL: Bool {
        let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
    
    var isValidZip: Bool {
        let passwordRegex = "[0-9]{4,10}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with:self)
    }
}

// MARK:- Extension UI Application
// MARK:-

extension UIApplication {
    
    var topMostViewControllerMIV: UIViewController {
        
        var topViewController = self.keyWindow?.rootViewController
        
        while topViewController?.presentedViewController != nil {
            topViewController = topViewController?.presentedViewController
        }
        
        return topViewController!
    }
}

