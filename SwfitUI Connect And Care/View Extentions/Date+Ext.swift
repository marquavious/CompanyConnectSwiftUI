//
//  Date+Ext.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation

extension Date {

    static func parseDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

}
