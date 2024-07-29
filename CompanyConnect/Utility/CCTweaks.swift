//
//  CCTweak.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/29/24.
//

import Foundation

enum CCTweaks: Int, CaseIterable {
    case internetSpeed = 0

    var key: String {
        switch self {
        case .internetSpeed:
            InternetSpeedTweak.key
        }
    }

    var title: String {
        switch self {
        case .internetSpeed:
            InternetSpeedTweak.title
        }
    }

    var currentConfigurationTitle: String {
        switch self {
        case .internetSpeed:
            CCTweakManager.shared.retreiveTweakValue(tweak: .internetSpeed).optionDisplayName
        }
    }

    var options: [String: String] {
        switch self {
        case .internetSpeed:
            InternetSpeedTweak.options
        }
    }
}
