import Foundation
import SwiftUI
import Factory

extension Container {
    var mapService: Factory<MapServiceType> {
        switch AppConfig.shared.enviorment {
        case .production:
            self { MapService() }
        case .offline:
            self { OfflineMapService() }
        case .development:
            self { DevMapService() }
        }
    }
}

protocol MapServiceType: HTTPDataDownloader {
    func getMapData() async throws -> MapViewJSONResponse
}

@Observable
class MapService: MapServiceType {
    func getMapData() async throws -> MapViewJSONResponse {
        return try await getData(as: MapViewJSONResponse.self, from: URLBuilder.mapdata.url)
    }
}

@Observable
class DevMapService: MapServiceType {
    func getMapData() async throws -> MapViewJSONResponse {
        return MapViewJSONResponse(companyObjects: Company.createFakeComapnyList())
    }
}

@Observable
class OfflineMapService: MapServiceType {
    func getMapData() async throws -> MapViewJSONResponse {
        return try await getData(as: MapViewJSONResponse.self, from: URLBuilder.mapdata.url)
    }
}
