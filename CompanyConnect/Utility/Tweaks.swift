//
//  Tweaks.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/26/24.
//

import Foundation
import OHHTTPStubs

enum InternetSpeedTweak: TimeInterval, Tweakable {
    typealias T = TimeInterval

    case simulateSlowInternetConnection = 0
    case simulateNormlInternetSpeed
    case simulateFastInternetConnection

    static var key: String {
        "InternetSpeedTweakKey"
    }

    static var tweakWindowName: String {
        "Internet Speed"
    }

    var displayName: String {
        switch self {
        case .simulateSlowInternetConnection:
            return "Slow Speed"
        case .simulateNormlInternetSpeed:
            return "Normal Speed"
        case .simulateFastInternetConnection:
            return "Fast Speed"
        }
    }

    //OHHTTPStubsDownloadSpeedGPRS   =    -7 =    7 KB/s =    56 kbps
    //OHHTTPStubsDownloadSpeedEDGE   =   -16 =   16 KB/s =   128 kbps
    //OHHTTPStubsDownloadSpeed3G     =  -400 =  400 KB/s =  3200 kbps
    //OHHTTPStubsDownloadSpeed3GPlus =  -900 =  900 KB/s =  7200 kbps
    //OHHTTPStubsDownloadSpeedWifi   = -1500 = 1500 KB/s = 12000 kbps

    func value() -> TimeInterval {
        switch self {
        case .simulateSlowInternetConnection:
            OHHTTPStubsDownloadSpeedGPRS
        case .simulateNormlInternetSpeed:
            OHHTTPStubsDownloadSpeed3G
        case .simulateFastInternetConnection:
            OHHTTPStubsDownloadSpeedWifi
        }
    }

}
