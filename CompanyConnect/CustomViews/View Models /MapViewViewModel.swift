import Foundation
import SwiftUI

protocol MapViewViewModelType {
    var loadingState: LoadingState { get }
    func loadMapData() async
    func allCompanies() -> [CompanyObject]
    func categories() -> [Category]
    func selctedCategories() -> [Category]
    func hasSelectedCategories() -> Bool
    func presentedCompanies() -> [CompanyObject]
    func resetSelectedCategories()
    func handleSelectedCategory(_ category: Category)
}

struct MapData: Codable {
    let companyObjects: [CompanyObject]
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

@Observable
class OfflineMapViewViewModel: MapViewViewModelType, ObservableObject {

    private let mapServiceType: MapServiceType = OfflineMapService()
    private var mapData: MapData = MapData(companyObjects: [])
    private var selectedCategories = [Category]()

    var loadingState: LoadingState = .loading

    func loadMapData() async {
        loadingState = .loading
        do {
            let mapViewJSONResponse = try await mapServiceType.getMapData()
            mapData = MapData(companyObjects: mapViewJSONResponse.companyObjects)
            loadingState = .fetched
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
                nsError.code == NSURLErrorCancelled {
                //Handle cancellation
            } else {
                //Handle failure
                loadingState = .error(error)
            }
        }
    }

    func allCompanies() -> [CompanyObject] {
        mapData.companyObjects
    }
    
    func categories() -> [Category] {
        Category.allCases
    }

    func selctedCategories() -> [Category] {
        selectedCategories
    }

    func hasSelectedCategories() -> Bool {
        !selectedCategories.isEmpty
    }
    
    func presentedCompanies() -> [CompanyObject] {
        if selectedCategories.isEmpty {
            return mapData.companyObjects
        }

        var tempArray = [CompanyObject]()
        for category in selectedCategories {
            for company in mapData.companyObjects {
                if company.category == category {
                    tempArray.append(company)
                }
            }
        }

        return tempArray
    }
    
    func resetSelectedCategories() {
        selectedCategories.removeAll()
    }

    func handleSelectedCategory(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll(where: { $0 == category })
        } else if !selectedCategories.contains(category) {
            selectedCategories.append(category)
        }
    }
}

@Observable
class DevMapViewViewModel: MapViewViewModelType, ObservableObject {

    var mapData: MapData = MapData(companyObjects: [])
    var selectedCategories = [Category]()

    var loadingState: LoadingState

    init(loadingState: LoadingState = .loading) {
        self.loadingState = loadingState
    }

    func loadMapData() async { 
        mapData = MapData(companyObjects: CompanyObject.createFakeComapnyList())
        loadingState = .fetched
    }

    func allCompanies() -> [CompanyObject] {
        mapData.companyObjects
    }

    func categories() -> [Category] {
        Category.allCases
    }

    func selctedCategories() -> [Category] {
        selectedCategories
    }

    func hasSelectedCategories() -> Bool {
        !selectedCategories.isEmpty
    }

    func presentedCompanies() -> [CompanyObject] {
        if selectedCategories.isEmpty {
            return mapData.companyObjects
        }

        var tempArray = [CompanyObject]()
        for category in selectedCategories {
            for company in mapData.companyObjects {
                if company.category == category {
                    tempArray.append(company)
                }
            }
        }

        return tempArray
    }

    func resetSelectedCategories() {
        selectedCategories.removeAll()
    }

    func handleSelectedCategory(_ category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll(where: { $0 == category })
        } else if !selectedCategories.contains(category) {
            selectedCategories.append(category)
        }
    }
}
