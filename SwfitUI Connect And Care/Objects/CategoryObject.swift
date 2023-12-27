//
//  CategoryObject.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 12/11/23.
//

import Foundation
import SwiftUI
import Observation

/*
@Observable
enum Category: Hashable {
//    init(name: String, color: Color) {
//        self.name = name
//        self.color = color
//    }
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    public static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }

    let id = UUID()
    let name: String
    let color: Color

    static func createCategoryList() -> [Category] {
        return [
            Category(name: "Health Care", color: .red),
            Category(name: "Women's Advancement", color: .teal),
            Category(name: "Human Rights", color: .purple),
            Category(name: "Environmental Issues", color: .mint),
            Category(name: "Community Building", color: .green),
            Category(name: "Conflict Relief", color: .pink),
            Category(name: "Veterans", color: .orange),
            Category(name: "Education", color: .blue),
            Category(name: "Indigenous Rights", color: .yellow)
        ]
    }
}
*/

//enum Category: Hashable {
//    case .healthCare, .healthCare,.healthCare,.healthCare,.healthCare,.healthCare,.healthCare,
//}

enum Category: String, Codable, CaseIterable {
    case healthcare, womensRights,
    humanRights, environmental,
    community, conflictReleief,
    veterans, education, indigenousRights

    var name: String {
        switch self {
        case .healthcare:
            return "Health Care"
        case .womensRights:
            return "Women's Advancement"
        case .humanRights:
            return "Human Rights"
        case .environmental:
            return "Environmental Issues"
        case .community:
            return "Community Building"
        case .conflictReleief:
            return "Conflict Relief"
        case .veterans:
            return "Veterans"
        case .education:
            return "Education"
        case .indigenousRights:
            return "Indigenous Rights"
        }
    }

    var color: Color {
        switch self {

        case .healthcare:
            return .red
        case .womensRights:
            return .pink
        case .humanRights:
            return .blue
        case .environmental:
            return .green
        case .community:
            return .purple
        case .conflictReleief:
            return .mint
        case .veterans:
            return .cyan
        case .education:
            return .yellow
        case .indigenousRights:
            return .teal
        }
    }

    static func createCategoryList() -> [Category] {
        return Self.allCases.map { $0 }

    }
}
