//
//  InternetSpeedTweak.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/26/24.
//

import Foundation
import OHHTTPStubs

enum InternetSpeedTweak: Int, Tweakable {

    typealias T = TimeInterval

    case simulateSlowInternetConnection = 0
    case simulateNormlInternetSpeed
    case simulateFastInternetConnection

    init?(value: TimeInterval) {
        switch value {
        case OHHTTPStubsDownloadSpeedGPRS:
            self = .simulateSlowInternetConnection
        case OHHTTPStubsDownloadSpeed3G:
            self = .simulateNormlInternetSpeed
        case OHHTTPStubsDownloadSpeedWifi:
            self = .simulateFastInternetConnection
        default:
            return nil
        }
    }

    static var key: String {
        "InternetSpeedTweakKey"
    }

    static var title: String {
        "Internet Speed"
    }

    var optionDisplayName: String {
        switch self {
        case .simulateSlowInternetConnection:
            return "Slow Speed"
        case .simulateNormlInternetSpeed:
            return "Normal Speed"
        case .simulateFastInternetConnection:
            return "Fast Speed"
        }
    }

    static var options: [String : String] {
        return [
            String(simulateSlowInternetConnection.rawValue) : simulateSlowInternetConnection.optionDisplayName,
            String(simulateNormlInternetSpeed.rawValue) : simulateNormlInternetSpeed.optionDisplayName,
            String(simulateFastInternetConnection.rawValue) : simulateFastInternetConnection.optionDisplayName
        ]
    }

    //OHHTTPStubsDownloadSpeedGPRS   =    -7 =    7 KB/s =    56 kbps
    //OHHTTPStubsDownloadSpeedEDGE   =   -16 =   16 KB/s =   128 kbps
    //OHHTTPStubsDownloadSpeed3G     =  -400 =  400 KB/s =  3200 kbps
    //OHHTTPStubsDownloadSpeed3GPlus =  -900 =  900 KB/s =  7200 kbps
    //OHHTTPStubsDownloadSpeedWifi   = -1500 = 1500 KB/s = 12000 kbps

    var value: TimeInterval {
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
