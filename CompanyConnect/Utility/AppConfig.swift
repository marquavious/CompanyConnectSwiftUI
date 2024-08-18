//
//  AppConfig.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/18/24.
//

import Foundation

enum ApplicationEnviorment: String {
    case production = "PRODUCTION"
    case offline = "OFFLINE"
    case development = "DEVELOPMENT"
}

class AppConfig: ObservableObject {
    let enviorment: ApplicationEnviorment

    static let shared = AppConfig.init()

    private init() {
        let configEnvString: String
        do {
            configEnvString = try Configuration.value(for: ConfiKeys.APPLICATION_ENVIRONMENT.rawValue)
        } catch {
            fatalError("Could not load APPLICATION_ENVIRONMENT variable")
        }

        guard
            let enviorment = ApplicationEnviorment(rawValue: configEnvString)
        else {
            fatalError("Could not crate DependencyGraph from Config.")
        }

        self.enviorment = enviorment
    }
}
