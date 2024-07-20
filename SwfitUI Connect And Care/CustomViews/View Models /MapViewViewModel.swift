import Foundation
import SwiftUI

protocol MapViewViewModelType {
    func allCompanies() -> [CompanyObject]
    func categories() -> [Category]
    func selctedCategories() -> [Category]
    func hasSelectedCategories() -> Bool
    func presentedCompanies() -> [CompanyObject]
    func resetSelectedCategories()
    func handleSelectedCategory(_ category: Category)
}

typealias MapData = [CompanyObject]

protocol MapServiceType {
    func getMapData() async throws -> MapData
}

@Observable
class OfflineMapService: MapServiceType {

    func getMapData() async throws -> MapData {
        return CompanyObject.createFakeComapnyList()
    }
}

@Observable
class OfflineMapViewViewModel: MapViewViewModelType, ObservableObject {

    private let mapServiceType: MapServiceType
    private var mapData: MapData = MapData()
    private var selectedCategories = [Category]()

    init(mapServiceType: MapServiceType) {
        self.mapServiceType = mapServiceType
    }

    func loadMapData() async {
        do {
            mapData = try await mapServiceType.getMapData()
        } catch {
            // Handle Error
        }
    }

    func allCompanies() -> [CompanyObject] {
        mapData
    }
    
    func categories() -> [Category] {
        mapData.compactMap { $0.category }
    }

    func selctedCategories() -> [Category] {
        selectedCategories
    }

    func hasSelectedCategories() -> Bool {
        selectedCategories.isEmpty
    }
    
    func presentedCompanies() -> [CompanyObject] {
        if selectedCategories.isEmpty {
            return mapData
        }

        var tempArray = [CompanyObject]()
        for category in selectedCategories {
            for company in mapData {
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
class FakeMapViewViewModel: MapViewViewModelType, ObservableObject {

    var mapData: MapData = CompanyObject.createFakeComapnyList()
    var selectedCategories = [Category]()

    func allCompanies() -> [CompanyObject] {
        mapData
    }

    func categories() -> [Category] {
        mapData.compactMap { $0.category }
    }

    func selctedCategories() -> [Category] {
        selectedCategories
    }

    func hasSelectedCategories() -> Bool {
        selectedCategories.isEmpty
    }

    func presentedCompanies() -> [CompanyObject] {
        if selectedCategories.isEmpty {
            return mapData
        }

        var tempArray = [CompanyObject]()
        for category in selectedCategories {
            for company in mapData {
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
