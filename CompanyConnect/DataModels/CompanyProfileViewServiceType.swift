//
//  CompanyProfileViewServiceType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/3/24.
//

import Foundation

protocol CompanyProfileViewServiceType: HTTPDataDownloader {
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse
}

@Observable
class CompanyProfileViewService: CompanyProfileViewServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return CompanyProfileViewJSONResponse(companyObject: CompanyObject.createFakeCompanyObject()) // CHANGE
    }
}

@Observable
class DevCompanyProfileViewService: CompanyProfileViewServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return CompanyProfileViewJSONResponse(companyObject: CompanyObject.createFakeCompanyObject())
    }
}

@Observable
class OfflineCompanyProfileViewService: CompanyProfileViewServiceType {
    @MainActor
    func getCompnayInfo(companyID: String) async throws -> CompanyProfileViewJSONResponse {
        return try await getData(as: CompanyProfileViewJSONResponse.self, from: URLBuilder.companyProfile(companyID: companyID).url)
    }
}
