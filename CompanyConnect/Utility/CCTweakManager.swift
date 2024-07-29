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

    func retreiveTweakValue(tweak: CCTweaks) -> any Tweakable {
        switch tweak {
        case .internetSpeed:
            if let tweakValue = retriveTweakInUserDefaults(tweak: tweak) as TimeInterval?,
               let internetSpeedTweak = InternetSpeedTweak(value: tweakValue) {
                return internetSpeedTweak
            } else {
                return InternetSpeedTweak.simulateNormlInternetSpeed
            }
        }
    }

    func saveTweakValue<T>(tweak: CCTweaks, value: T) {
        switch tweak {
        case .internetSpeed:
            saveTweakInUserDefaults(tweak: tweak, value: value)
        }
    }

    func resetTwekValue(tweak: CCTweaks) {
        switch tweak {
        case .internetSpeed:
            resetTweakInUserDefaults(tweak: .internetSpeed)
        }
    }

    private func saveTweakInUserDefaults<T>(tweak: CCTweaks, value: T) {
        UserDefaults.standard.setValue(value, forKey: tweak.key)
        UserDefaults.standard.synchronize()
    }

    private func retriveTweakInUserDefaults<T>(tweak: CCTweaks) -> T? {
        UserDefaults.standard.value(forKey: tweak.key) as? T ?? nil
    }

    private func resetTweakInUserDefaults(tweak: CCTweaks) {
        UserDefaults.standard.removeObject(forKey: tweak.key)
        UserDefaults.standard.synchronize()
    }
}
