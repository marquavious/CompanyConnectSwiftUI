//
//  CCTweakManager.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/28/24.
//

import Foundation

enum Tweaks: Int, CaseIterable {
    case internetSpeed = 0

    var key: String {
        switch self {
        case .internetSpeed:
            InternetSpeedTweak.key
        }
    }

    var displayName: String {
        switch self {
        case .internetSpeed:
            InternetSpeedTweak.tweakWindowName
        }
    }

    var numberOfOptions: Int {
        switch self {
        case .internetSpeed:
            InternetSpeedTweak.allCases.count
        }
    }
}

class CCTweakManager {

    static let shared = CCTweakManager()

    private init () { }


    func retreiveTweakValue(tweak: Tweaks) -> any Tweakable {
        switch tweak {
        case .internetSpeed:
            if let tweakValue = retriveTweakInUserDefaults(tweak: tweak) as TimeInterval?,
               let internetSpeedTweak = InternetSpeedTweak(rawValue: tweakValue) {
                return internetSpeedTweak
            } else {
                return InternetSpeedTweak.simulateNormlInternetSpeed
            }
        }
    }

    func saveTweakValue<T>(tweak: Tweaks, value: T) {
        switch tweak {
        case .internetSpeed:
            saveTweakInUserDefaults(tweak: tweak, value: value)
        }
    }

    func resetTwekValue(tweak: Tweaks) {
        switch tweak {
        case .internetSpeed:
            resetTweakInUserDefaults(tweak: .internetSpeed)
        }
    }

    private func saveTweakInUserDefaults<T>(tweak: Tweaks, value: T) {
        UserDefaults.standard.setValue(value, forKey: tweak.key)
    }

    private func retriveTweakInUserDefaults<T>(tweak: Tweaks) -> T? {
        UserDefaults.standard.value(forKey: tweak.key) as? T ?? nil
    }

    private func resetTweakInUserDefaults(tweak: Tweaks) {
        UserDefaults.standard.removeObject(forKey: tweak.key)
    }
}
