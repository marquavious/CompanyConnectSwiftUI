//
//  CCTweakManager.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/28/24.
//

import Foundation

class CCTweakManager {

    static let shared = CCTweakManager()

    private init () { }

    enum Tweak {
        case internetSpeed

        var key: String {
            switch self {
            case .internetSpeed:
                InternetSpeedTweak.key
            }
        }
    }

    func retreiveTweakValue(tweak: Tweak) -> any Tweakable {
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

    func saveTweakValue<T>(tweak: Tweak, value: T) {
        switch tweak {
        case .internetSpeed:
            saveTweakInUserDefaults(tweak: tweak, value: value)
        }
    }

    func resetTwekValue(tweak: Tweak) {
        switch tweak {
        case .internetSpeed:
            resetTweakInUserDefaults(tweak: .internetSpeed)
        }
    }

    private func saveTweakInUserDefaults<T>(tweak: Tweak, value: T) {
        UserDefaults.standard.setValue(value, forKey: tweak.key)
    }

    private func retriveTweakInUserDefaults<T>(tweak: Tweak) -> T? {
        UserDefaults.standard.value(forKey: tweak.key) as? T ?? nil
    }

    private func resetTweakInUserDefaults(tweak: Tweak) {
        UserDefaults.standard.removeObject(forKey: tweak.key)
    }
}
