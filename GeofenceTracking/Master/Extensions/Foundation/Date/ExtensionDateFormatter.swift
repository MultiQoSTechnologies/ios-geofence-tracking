//
//  ExtensionDateFormatter.swift
//  TheBayaApp
//
//  Created by mac-0005 on 13/09/18.
//  Copyright © 2018 mac-0005. All rights reserved.
//

import UIKit

// MARK:- Date Related Functions
// MARK:-

let kHHmm = "HH:mm"
let kddMMMYYYhhmm = "dd MMM yyyy, HH:mm"
let kddMMYYYY = "dd/MM/yyyy"
let kAPIddMMYYYY = "dd-MM-yyyy"
let kdMMMYYYY = "d MMMM yyyy"
let kddMMMYYYY = "dd MMM, yyyy"
let kddMMMYYYYnhhmma = "dd MMM yyyy,\nHH:mm a"

//MARK:-
//MARK:- Extension - DateFormatter Singleton
extension DateFormatter {
    private static var sharedInstance: DateFormatter = {
        let dateFormatter = DateFormatter()
       // dateFormatter.timeZone = NSTimeZone.system
//        if Localization.sharedInstance.getLanguage() == CLanguageArabic {
//            dateFormatter.locale = Locale(identifier: "ar_DZ")
//        }
//        else {
 //         dateFormatter.locale = NSLocale.current
//        }
        return dateFormatter
    }()
    
    static func shared() -> DateFormatter {
        return sharedInstance
    }
    
    func string(fromDate:Date, dateFormat:String) -> String {
        self.dateFormat = dateFormat
        return self.string(from: fromDate)
    }
    
    func date(fromString:String, dateFormat:String) -> Date? {
        self.dateFormat = dateFormat
        return self.date(from: fromString)
    }
    
    func stringGMT(fromDate:Date, dateFormat: String) -> String {
        self.dateFormat = dateFormat
        DateFormatter.shared().timeZone = TimeZone(abbreviation: "GMT")
        return DateFormatter.shared().string(from: fromDate)
    }
    
    func dateGMT(fromString:String, dateFormat: String) -> Date? {
        self.dateFormat = dateFormat
        DateFormatter.shared().timeZone = TimeZone(abbreviation: "GMT")
        return DateFormatter.shared().date(from: fromString)
    }
}


extension DateFormatter {
    
    private static var sharedInstanceMIV: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        return dateFormatter
    }()
    
    static func sharedMIV() -> DateFormatter {
        return sharedInstanceMIV
    }
    
    func stringMIV(fromDate: Date, dateFormat: String) -> String {
        self.dateFormat = dateFormat
        return self.string(from: fromDate)
    }
    
    func dateMIV(fromString: String, dateFormat: String) -> Date? {
        self.dateFormat = dateFormat
        return self.date(from: fromString)
    }
}

extension DateFormatter {
    
    // To Get date string from timestamp
    static func dateStringFrom(timestamp: Double?, withFormate:String?) -> String {
        guard let timestamp = timestamp else { return "" }
        let fromDate:Date = Date(timeIntervalSince1970: timestamp/1000)
        DateFormatter.shared().locale = NSLocale.current
        DateFormatter.shared().timeZone = TimeZone.current
        /*
         if Localization.sharedInstance.getLanguage() == CLanguageArabic {
         DateFormatter.shared().locale = Locale(identifier: "ar_DZ")
         } else {
         DateFormatter.shared().locale = NSLocale.current
         }
         */
        return DateFormatter.shared().string(fromDate: fromDate, dateFormat: withFormate!)
    }
    
    // To Get date from timestamp
    func dateFrom(timestamp: String) -> Date? {
        let fromDate:Date = Date(timeIntervalSince1970: Double(timestamp)!)
        let stringDate = DateFormatter.shared().string(fromDate: fromDate, dateFormat: "dd MMM, YYYY")
        return DateFormatter.shared().date(fromString: stringDate, dateFormat: "dd MMM, YYYY")
    }
    
    // To get specific date string fromate from specific date string
    func convertDateFormat(date : String?, currentformate : String?, updateformate : String?) -> String? {
        let dateString = date
        var dateInfo = ""
        self.dateFormat = currentformate // "dd-MM-yyyy hh:mm a"
        
        if let strCurrnetDate = self.date(from: dateString!){
            self.dateFormat = updateformate //"dd-MMM-yyyy hh:mm a"
            dateInfo = self.string(from: strCurrnetDate)
        }
        
        return dateInfo
    }
    
    // To compare two date with same formate
    func compareTwoDates(startDate : String?, endDate : String?, formate : String?) -> Bool {
        self.dateFormat = formate
        self.timeZone = TimeZone(abbreviation: "GMT")
        let startDateTimeStamp = self.date(from: startDate!)?.timeIntervalSince1970
        let endDateTimeStamp = self.date(from: endDate!)?.timeIntervalSince1970
        return Double(endDateTimeStamp!) > Double(startDateTimeStamp!)
    }
    
    func convertDateIntoGMTDate(dateToConvert: String?,  formate : String?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        let convertedDate = formatter.date(from: dateToConvert ?? "")
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: convertedDate!)
    }
    
    func durationString(fromDate: String, toDate: String) -> (totalDays: String, remainingDays: String) {
        let calendar: Calendar = Calendar.current as Calendar
        let fromDate: Date = Date(timeIntervalSince1970: Double(fromDate)!)
        let toDate: Date = Date(timeIntervalSince1970: Double(toDate)!)
        let unitFlags = Set<Calendar.Component>([.day])
        let dateComponents = calendar.dateComponents(unitFlags, from: fromDate, to: toDate)
        
        let remaining = calendar.dateComponents(unitFlags, from: Date(), to: toDate)
        let remainingDays = "\(remaining.day!)" as String
        
        let days = dateComponents.day!
        let durations = "\(days)" as String
        
        return (durations, remainingDays)
    }
    
    // To get duration string from timestamp    
    func durationStringForChat(duration: String) -> String {
        let fromDate:Date = Date(timeIntervalSince1970: ((duration.toDouble ?? 0.0)/1000))
        let fromDateFormat = fromDate.toDate(format: "dd MM yyyy")
        let todayDateFormat = Date().toDate(format: "dd MM yyyy")
        
        var durations = AppMessages.CJustNow
        
        if (fromDateFormat == todayDateFormat)  {
            durations = DateFormatter.dateStringFrom(timestamp: (duration.toDouble ?? 0.0)/1000, withFormate: kHHmm)
        } else {
            durations = DateFormatter.dateStringFrom(timestamp: (duration.toDouble ?? 0.0)/1000, withFormate: kddMMMYYYhhmm)
        }
        
        return durations;
    }
    
    func durationStringForNotification(duration: String) -> String {
        let calender:Calendar = Calendar.current as Calendar
        let fromDate:Date = Date(timeIntervalSince1970: (Double(duration) ?? 0.0)/1000 )
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        let dateComponents = calender.dateComponents(unitFlags, from:fromDate , to: Date())
        
        let years:NSInteger = dateComponents.year!
        let months:NSInteger = dateComponents.month!
        let days:NSInteger = dateComponents.day!
        let hours:NSInteger = dateComponents.hour!
        let minutes:NSInteger = dateComponents.minute!
        let seconds: NSInteger = dateComponents.second!
        
        var durations:NSString = AppMessages.CJustNow as NSString
                
        if (years > 0) {
            let ago = years == 1 ? AppMessages.CYearAgo : AppMessages.CYearsAgo
            durations = "\(years) \(ago)" as NSString
        }
        else if (months > 0) {
            let ago = months == 1 ? AppMessages.CMonthAgo : AppMessages.CMonthsAgo
            durations = "\(months) \(ago)" as NSString
        }
        else if (days > 0) {
            let ago = days == 1 ? AppMessages.CDaysAgo : AppMessages.CDaysAgo
                durations = "\(days) \(ago)" as NSString
        }
        else if (hours > 0) {
            durations = (hours == 1 ? AppMessages.CAnHourAgo : "\(hours) \(AppMessages.CHoursAgo)") as NSString
        }
        else if (minutes > 0) {
            durations = (minutes == 1 ? AppMessages.CMinAgo : "\(minutes) \(AppMessages.CMinsAgo)") as NSString
        }
        else if (seconds > 0) {
            durations = (seconds < 10 ? AppMessages.CJustNow : "\(seconds) \(AppMessages.CSecsAgo)") as NSString
        }
        
        return durations as String;
    }

}

// MARK:- Timestamp Related Functions
extension DateFormatter {
    // To Get GMT Timestamp from Specific Date
    func timestampGMTFromDate(date : String?, formate : String?) -> Double? {
        self.dateFormat = formate
        self.timeZone = TimeZone(abbreviation: "GMT")
        var timeStamp = self.date(from: date!)?.timeIntervalSince1970
        timeStamp = Double(timeStamp!)
        return timeStamp
    }
    
    // To Get local Timestamp from specific date
    func timestampFromDate(date : String?, formate : String?) -> Double? {
        self.dateFormat = formate
        self.timeZone = TimeZone.current
        var timeStamp = self.date(from: date!)?.timeIntervalSince1970
        //        timeStamp = Double((timeStamp?.toFloat)!)
        timeStamp = Double(timeStamp!)
        return timeStamp
    }
    
    // To Get GMT Timestamp from current date.
    func currentGMTTimestampInMilliseconds() -> Double? {
        let format = "yyyy-MM-dd HH:mm:ss.SSSS'Z'"
        self.dateFormat = format
        self.timeZone = TimeZone(identifier: "GMT")
        
        let createDate = self.string(from: Date())
        let timestamp = self.timestampGMTFromDate(date: createDate, formate: format)
        return timestamp! * 1000
    }
    
    // To Convert GMT timestamp to local timestamp
    func ConvertGMTMillisecondsTimestampToLocalTimestamp(timestamp: Double) -> Double? {
        let format = "yyyy-MM-dd HH:mm:ss.SSSS'Z'"
        self.dateFormat = format
        self.timeZone = TimeZone.current
        let dateStr = NSDate(timeIntervalSince1970:timestamp)
        let createDate = self.string(from: dateStr as Date)
        let gmtTimestamp = self.timestampFromDate(date: createDate, formate: format)
        return gmtTimestamp
    }
}
