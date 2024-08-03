//
//  CompanyProfileViewServiceType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/3/24.
//

import Foundation

protocol CompanyProfileViewServiceType: HTTPDataDownloader {
    func getCompnayInfo() async throws -> CompanyProfileViewJSONResponse
}

@Observable
class DevCompanyProfileViewService: CompanyProfileViewServiceType {
    @MainActor
    func getCompnayInfo() async throws -> CompanyProfileViewJSONResponse {
        return try await getData(as: CompanyProfileViewJSONResponse.self, from: URLBuilder.activityFeed.url)
    }
}

@Observable
class OfflineCompanyProfileViewService: CompanyProfileViewServiceType {
    @MainActor
    func getCompnayInfo() async throws -> CompanyProfileViewJSONResponse {
        return try await getData(as: CompanyProfileViewJSONResponse.self, from: URLBuilder.activityFeed.url)
    }
}
