//
//  Localization.swift
// 
//
//  Created by MultiQoS on 05/04/2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import UIKit

func LocalizationSetLanguage(language: String) {
    Localization.sharedInstance.setLanguage(language)
}

class Localization: NSObject {
    
    static let sharedInstance = Localization()
    
    private override init() {} // This prevents others from using the default '()' initializer for this class.
    
    static var bundle = Bundle.main
    
    func localizedString(forKey key: String, value comment: String) -> String {
        
        return Localization.bundle.localizedString(
            forKey: key,
            value: comment,
            table: nil
        )
    }
    
    func setLanguage(_ lang: String) {
        
        AppLogs.debugPrint("preferredLang: \(lang)")
        
        let path: String? = Bundle.main.path(
            forResource: lang,
            ofType: "lproj"
        )
        
        if path == nil {
            resetLocalization(lang) //in case the language does not exists
        } else {
            Localization.bundle = Bundle(path: path ?? "")!
        }
        
        setAppleLanguage(lang)
    }
    
    func getLanguage() -> String {
        
        guard let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [Any],
            !languages.isEmpty,
            let preferredLang = languages.first as? String,
            let lang = preferredLang.components(separatedBy: "-").first else {
                return ""
        }
        
        return lang
    }
    
    func resetLocalization(_ lang:String) {
        
        guard let path = Bundle.main.path(forResource: "Base", ofType: "lproj"),
            let bundle = Bundle(path: path) else{
                Localization.bundle = Bundle.main
                return
        }
        
        Localization.bundle = bundle
    }
    
    //MARK:- PRIVATE -
    private func setAppleLanguage(_ lang: String) {
        
        var languages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let cLangReg = languageWithCurrentRegion(lang)
        var isContain = false
        
        for (index, lang) in (languages?.enumerated())! {
            if lang == cLangReg {
                isContain = true
                languages = rearrange(array: languages!, fromIndex: index, toIndex: 0)
            }
        }
        
        if !isContain {
            languages?.insert(cLangReg!, at: 0)
        }
        
        UserDefaults.standard.set(languages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    private func languageWithCurrentRegion(_ lang:String) -> String? {
        
        _ = (NSLocale.current.regionCode != nil) ? ((NSLocale.current.regionCode?.isBlank)! ? "" : "-(NSLocale.current.regionCode!)") : "" 
        return "(lang)(currentRegion)"
    }
    
    private func rearrange<T>(array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T> {
        
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        
        return arr
    }
    
    func applicationFlowWithLanguageRTL() -> Bool {
        
        //        UIView.appearance().semanticContentAttribute = .forceRightToLeft (Like As - Arabic)
        var isRTL: Bool = false
        if UIView.appearance().semanticContentAttribute == .forceRightToLeft{
            isRTL = true
        }
        
        return isRTL
    }
    
}

