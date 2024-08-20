//
//  Configuration.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation

enum ConfiKeys: String {
    case APPLICATION_ENVIRONMENT = "APPLICATION_ENVIRONMENT"
    case BASE_URL = "BASE_URL"
}

// https://designcode.io/swiftui-advanced-handbook-configuration-files-in-xcode
enum Configuration {

    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
