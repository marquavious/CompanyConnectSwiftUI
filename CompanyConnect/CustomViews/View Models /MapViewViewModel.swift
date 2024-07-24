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

struct MapData: Codable {
    let companyObjects: [CompanyObject]
}

protocol MapServiceType {
    func getMapData() async throws -> MapData
}

@Observable
class DevMapService: MapServiceType {

    func getMapData() async throws -> MapData {
        return MapData(companyObjects: CompanyObject.createFakeComapnyList())
    }
}

@Observable
class OfflineMapService: MapServiceType {

    func getMapData() async throws -> MapData {
        return MapData(companyObjects: [])
    }
}

@Observable
class OfflineMapViewViewModel: MapViewViewModelType, ObservableObject {

    private let mapServiceType: MapServiceType
    private var mapData: MapData = MapData(companyObjects: [])
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

    var mapData: MapData
    var selectedCategories = [Category]()

    init() {
        self.mapData = MapData(companyObjects: CompanyObject.createFakeComapnyList())
        self.selectedCategories = selectedCategories
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
