//
//  Date+Ext.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation

extension Date {
  static func randomWithin24Hours() -> Date {
    let calendar = Calendar.current
    let randomTimeOffset = TimeInterval.random(in: -1440...0) // -24 hours to +24 hours in seconds
    return calendar.date(byAdding: .second, value: Int(randomTimeOffset), to: .now)!
  }
}

extension Date {
    static func parseDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

extension Date {
  static func timeAgo(for date: Date) -> String {
    let formatter = ISO8601DateFormatter()
    formatter.timeZone = TimeZone.current

    let now = Date()
    let calendar = Calendar.current

    let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)

    let year = components.year!
    let month = components.month!
    let day = components.day!
    let hour = components.hour!
    let minute = components.minute!
    let second = components.second!

    if year > 0 {
      return formatter.string(from: date) // Use ISO 8601 for dates older than a year
    } else if month > 0 {
      return "\(month)mo" // "mo" for months
    } else if day > 0 {
      return "\(day)d" // "d" for days
    } else if hour > 0 {
      return "\(hour)h" // "h" for hours
    } else if minute > 0 {
      return "\(minute)m" // "m" for minutes
    } else if second > 0 {
      return "\(second)s"
    } else {
      return "now" // Less than a minute
    }
  }
}
