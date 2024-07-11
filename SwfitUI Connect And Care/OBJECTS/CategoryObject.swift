//
//  CategoryObject.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 12/11/23.
//

import Foundation
import SwiftUI
import Observation

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

    static func returnRandom() -> Category {
        return [.healthcare, .womensRights, .humanRights, .environmental, .community, .conflictReleief, .veterans, .education, .indigenousRights].randomElement()!
    }

    var random: Self {
        return [.healthcare, .womensRights, .humanRights, .environmental, .community, .conflictReleief, .veterans, .education, .indigenousRights].randomElement()!
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
