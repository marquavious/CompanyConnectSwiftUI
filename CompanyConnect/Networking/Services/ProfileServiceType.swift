//
//  CompanyProfileViewServiceType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/3/24.
//

import Foundation
import Factory

extension Container {
    var profileServiceType: Factory<ProfileServiceType> {
        switch AppConfig.shared.enviorment {
        case .production:
            self { CompanyProfileViewService() }
        case .offline:
            self { OfflineCompanyProfileViewService() }
        case .development:
            self { DevCompanyProfileViewService() }
        }
    }
}

protocol ProfileServiceType: HTTPDataDownloader {
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse
}

@Observable
class CompanyProfileViewService: ProfileServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return CompanyProfileViewJSONResponse(companyObject: Company.createFakeCompanyObject()) // CHANGE
    }
}

@Observable
class DevCompanyProfileViewService: ProfileServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return CompanyProfileViewJSONResponse(companyObject: Company.createFakeCompanyObject())
    }
}

@Observable
class OfflineCompanyProfileViewService: ProfileServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return try await getData(as: CompanyProfileViewJSONResponse.self, from: URLBuilder.companyProfile(companyID: companyID).url)
    }
}
