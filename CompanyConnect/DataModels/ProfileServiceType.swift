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
        self { CompanyProfileViewService() }
    }
}

protocol ProfileServiceType: HTTPDataDownloader {
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse
}

@Observable
class CompanyProfileViewService: ProfileServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return CompanyProfileViewJSONResponse(companyObject: CompanyObject.createFakeCompanyObject()) // CHANGE
    }
}

@Observable
class DevCompanyProfileViewService: ProfileServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return CompanyProfileViewJSONResponse(companyObject: CompanyObject.createFakeCompanyObject())
    }
}

@Observable
class OfflineCompanyProfileViewService: ProfileServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return try await getData(as: CompanyProfileViewJSONResponse.self, from: URLBuilder.companyProfile(companyID: companyID).url)
    }
}
