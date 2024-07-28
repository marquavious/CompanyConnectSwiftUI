//
//  Tweaks.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/26/24.
//

import Foundation
import OHHTTPStubs

enum InternetSpeedTweak: Double, Tweakable {
    typealias T = Double

    case simulateSlowInternetConnection = 0
    case simulateNormlInternetSpeed
    case simulateFastInternetConnection

    static var key: String {
        "InternetSpeedTweakKey"
    }

    func value() -> Double {
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

//OHHTTPStubsDownloadSpeedGPRS   =    -7 =    7 KB/s =    56 kbps
//OHHTTPStubsDownloadSpeedEDGE   =   -16 =   16 KB/s =   128 kbps
//OHHTTPStubsDownloadSpeed3G     =  -400 =  400 KB/s =  3200 kbps
//OHHTTPStubsDownloadSpeed3GPlus =  -900 =  900 KB/s =  7200 kbps
//OHHTTPStubsDownloadSpeedWifi   = -1500 = 1500 KB/s = 12000 kbps
