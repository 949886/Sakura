//
//  NSDateExtension.swift
//  Sakura
//
//  Created by YaeSakura on 2017/4/19.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

import Foundation

extension NSDate
{
    //Date components.
    public var year : Int { return Date.calendar.component(.year, from: self as Date as Date) }
    public var month : Int { return Date.calendar.component(.month, from: self as Date) }
    public var day : Int { return Date.calendar.component(.day, from: self as Date) }
    public var weekday : Int { return Date.calendar.component(.weekday, from: self as Date) }
    public var hour : Int { return Date.calendar.component(.hour, from: self as Date) }
    public var minute : Int { return Date.calendar.component(.minute, from: self as Date) }
    public var second : Int { return Date.calendar.component(.second, from: self as Date) }
    public var millisecond : Int { return Date.calendar.component(.nanosecond, from: self as Date) / 1000000 }
    public var microsecond : Int { return Date.calendar.component(.nanosecond, from: self as Date) / 1000 }
    public var nanosecond : Int { return Date.calendar.component(.nanosecond, from: self as Date) }
    public var dayOfYear : Int { return Int(NSDate.format(date: self, format: "D")) ?? 0 }
    public var weekOfMonth : Int { return Date.calendar.component(.weekOfMonth, from: self as Date) }
    public var weekOfYear : Int { return Date.calendar.component(.weekOfYear, from: self as Date) }
    public var quarter : Int { return Date.calendar.component(.quarter, from: self as Date) }
}

// MARK: - Static

extension NSDate
{
    // MARK: - Public
    
    public static func parse(date: String, format: String) -> Date?
    {
        return Date.parse(date: date, format: format, locale: "en_US")
    }
    
    public static func parse(date: String, format: String, locale: String) -> Date?
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: locale)
        let parsedDate = formatter.date(from: date)
        return parsedDate
    }
    
    public static func format(date: NSDate, format: String) -> String
    {
        return NSDate.format(date: date, format: format, locale: "en_US")
    }
    
    public static func format(date: NSDate, format: String, locale: String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: locale)
        return formatter.string(from: date as Date)
    }
}
