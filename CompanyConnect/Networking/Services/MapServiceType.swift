import Foundation
import SwiftUI
import Factory
import Firebase
import FirebaseFirestore

extension Container {
    var mapService: Factory<MapServiceType> {
        switch AppConfig.shared.enviorment {
        case .production:
            self { FirebaseMapService() }
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
class FirebaseMapService: MapServiceType {
    func getMapData() async throws -> MapViewJSONResponse {
        do {
            // let snapshot = try await Database.database().reference().child("company_objects").child("company_objects").getData()
            // let cleanArray = try snapshot.data(as: [Company?].self).compactMap { $0 }
            // data(as: [Company?].self).compactMap { $0 }

            let snapshot = try await Firestore.firestore().collection("test_company_objects").getDocuments()
            let cleanArray = try snapshot.documents.compactMap { document in
                try document.data(as: Company.self)
            }
            return MapViewJSONResponse(companyObjects: cleanArray)
        }
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
