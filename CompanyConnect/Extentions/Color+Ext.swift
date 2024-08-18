//
//  Color+Ext.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/14/24.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
