import Foundation
import SwiftUI
import Factory

extension Container {
    var mapService: Factory<MapServiceType> {
        self { DevMapService() }
    }
}

protocol MapServiceType: HTTPDataDownloader {
    func getMapData() async throws -> MapViewJSONResponse
}

@Observable
class DevMapService: MapServiceType {

    func getMapData() async throws -> MapViewJSONResponse {
        return MapViewJSONResponse(companyObjects: CompanyObject.createFakeComapnyList())
    }
}

@Observable
class OfflineMapService: MapServiceType {

    func getMapData() async throws -> MapViewJSONResponse {
        return try await getData(as: MapViewJSONResponse.self, from: URLBuilder.mapdata.url)
    }
}
