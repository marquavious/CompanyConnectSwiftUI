//
//  CCTweakManager.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/28/24.
//

import Foundation

class CCTweakManager {

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
            if let tweakValue = retiveTweakInUserDefaults(tweak: tweak) as Double?,
               let internetSpeedTweak = InternetSpeedTweak(rawValue: tweakValue) {
                return internetSpeedTweak
            } else {
                return InternetSpeedTweak.simulateNormlInternetSpeed
            }
        }
    }

    func resetTwekValue(tweak: Tweak) {
        switch tweak {
        case .internetSpeed:
            resetTweakInUserDefaults(tweak: .internetSpeed)
        }
    }

    private func saveTweakInUserDefaults<T>(tweak: Tweak, value: T) {
        UserDefaults.standard.setValue(T.self, forKey: tweak.key)
    }

    private func retiveTweakInUserDefaults<T>(tweak: Tweak) -> T? {
        UserDefaults.standard.value(forKey: tweak.key) as? T ?? nil
    }

    private func resetTweakInUserDefaults(tweak: Tweak) {
        UserDefaults.standard.removeObject(forKey: tweak.key)
    }
}
