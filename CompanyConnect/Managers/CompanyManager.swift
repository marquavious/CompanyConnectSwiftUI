//
//  CompanyManager.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/18/24.
//

import Foundation
import SwiftData
import Factory

@Observable
class CompanyManager: ObservableObject {

    private (set) var allCompanies: [Company]
    private (set) var categoryFilter: CategoryManager

    var filteredCompanies: [Company] {
        filteredArray()
    }

    func searchTerm(term: String?) {
        guard let term, !term.isEmpty else { return }
    }

    func addCompany(company: Company) {
        allCompanies.append(company)
    }

    func setCompanies(companies: [Company]) {
        allCompanies = companies
    }

    init(comapnies: [Company] = [], categoryFilter: CategoryManager = CategoryManager()) {
        self.categoryFilter = categoryFilter
        self.allCompanies = comapnies
    }

    private func filteredArray() -> [Company] {
        if !categoryFilter.hasSelectedCategories {
            return allCompanies
        }

        var tempArray = [Company]()
        for category in categoryFilter.selctedCategories {
            for company in allCompanies {
                if company.category == category {
                    tempArray.append(company)
                }
            }
        }

        return tempArray
    }
}

/*
enum CompanyManagerError: Error {
    case saveCompaniesError(Error)
    case setupSwiftDataError(Error)
    case loadCompaniesError(Error)
}
protocol CompanyManagerType {
    var allCompanies: [Company] { get }
    var categoryManager: CategoryManager { get set }
    var categoryFilteredCompanies: [Company] { get }
    var shouldRefreshCache: Bool { get }
    func invalidateChache()
    func loadCompanyFromCache(id: String) -> Company?
    func saveCompaniesToCache(companies: [Company]) throws
    func clearChache()
}

extension Container {
    var companyManagerType: Factory<CompanyManagerType> {
        self { UserDefaultsCompanyManager() }
    }
}

@Observable
class UserDefaultsCompanyManager: ObservableObject, CompanyManagerType {

    var allCompanies: [Company] {
        guard let companyArray = UserDefaults.standard.value(forKey: "cached_company_object_array") as? [Company] else {
            return []
        }
        return companyArray
    }

    var categoryManager = CategoryManager()

    var categoryFilteredCompanies: [Company] {
        if !categoryManager.hasSelectedCategories {
            return allCompanies
        }

        // TODO: - Optimize
        var tempArray = [Company]()
        for category in categoryManager.selctedCategories {
            for company in allCompanies {
                if company.category == category {
                    tempArray.append(company)
                }
            }
        }

        return tempArray
    }

    var shouldRefreshCache: Bool {
        CacheDateManager.shared.compnayObjectsHaveExpired && allCompanies.isEmpty
    }

    func invalidateChache() {
        CacheDateManager.shared.clearUpdateLastUpdatedDate(key: .companyObjectsLastUpdatedDate)
    }
    
    func loadCompanyFromCache(id: String) -> Company? {
        UserDefaults.standard.object(forKey: "cached_company_object_with_ID:\(id)") as? Company
    }

    func saveCompaniesToCache(companies: [Company]) throws {
        for company in companies {
            UserDefaults.standard.setValue(Company.self, forKey: "cached_company_object_with_ID:\(company.id)")

            if var companyArray = UserDefaults.standard.value(forKey: "cached_company_object_array") as? [Company] {
                companyArray.append(company)
                UserDefaults.standard.setValue(companyArray, forKey: "cached_company_object_array")
            }
        }
    }

    func clearChache() {
        defer { invalidateChache() }
        for company in allCompanies {
            UserDefaults.standard.removeObject(forKey: "cached_company_object_with_ID:\(company.id)")
        }
    }
}

@Observable
class SwiftDataCompanyManager: ObservableObject, CompanyManagerType {
    var allCompanies = [Company]()
    var categoryManager = CategoryManager()

    var modelContext: ModelContext? = nil
    var modelContainer: ModelContainer? = nil

    var categoryFilteredCompanies: [Company] {
        if !categoryManager.hasSelectedCategories {
            return allCompanies
        }

        // TODO: - Optimize
        var tempArray = [Company]()
        for category in categoryManager.selctedCategories {
            for company in allCompanies {
                if company.category == category {
                    tempArray.append(company)
                }
            }
        }

        return tempArray
    }

    var shouldRefreshCache: Bool {
        CacheDateManager.shared.compnayObjectsHaveExpired && allCompanies.isEmpty
    }

    func invalidateChache() {
        CacheDateManager.shared.clearUpdateLastUpdatedDate(key: .companyObjectsLastUpdatedDate)
    }
    
    func loadCompanyFromCache(id: String) -> Company? {
        if
            let company = allCompanies.first(where: { $0.id == id }),
            !CacheDateManager.shared.compnayObjectsHaveExpired {
            return company
        }

        guard
            let modelContext = modelContext else { return nil}

        let companyDescriptor = FetchDescriptor<Company>(
            predicate: #Predicate { $0.id == id },
            sortBy: []
        )

        do {
            let company = try modelContext.fetch(companyDescriptor).first
            return company
        } catch {
            return nil
        }
    }
    
    func saveCompaniesToCache(companies: [Company]) throws {
        guard let modelContext = modelContext else { return }
        do {
            companies.forEach { modelContext.insert($0) }
            try modelContext.save()
            CacheDateManager.shared.updateLastUpdatedDate(key: .companyObjectsLastUpdatedDate)
            loadCompanies()
        } catch(let error) {
            throw CompanyManagerError.saveCompaniesError(error)
        }
    }
    
    func clearChache() {
        guard let modelContext = modelContext else { return }
        allCompanies.forEach { modelContext.delete($0)}
        invalidateChache()
        loadCompanies()
    }

    @MainActor
    private func setupSwiftData() {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
            let container = try ModelContainer(for: Company.self, configurations: configuration)
            modelContainer = container

            modelContext = container.mainContext
            modelContext?.autosaveEnabled = true

        } catch(let error) {
            print(error.localizedDescription)
        }
    }

    private func loadCompanies() {
        guard let modelContext = modelContext else { return }

        let companyDescriptor = FetchDescriptor<Company>(
            predicate: nil,
            sortBy: []
        )

        do {
            allCompanies = try modelContext.fetch(companyDescriptor)
        } catch(let error) {
            // Log error
            print(error.localizedDescription)
        }
    }

    @MainActor
    init() {
        setupSwiftData() // Important this runs first!
        loadCompanies()
    }


}
//
//@Observable
//class CompanyManager: ObservableObject, CompanyManagerType {
//    var categoryManager: CategoryManager
//
//    var allCompanies = [Company]()
//    private (set) var categoryFilter: CategoryManager
//
//    var modelContext: ModelContext? = nil
//    var modelContainer: ModelContainer? = nil
//
//    var categoryFilteredCompanies: [Company] {
//        if !categoryFilter.hasSelectedCategories {
//            return allCompanies
//        }
//
//        // TODO: - Optimize
//        var tempArray = [Company]()
//        for category in categoryFilter.selctedCategories {
//            for company in allCompanies {
//                if company.category == category {
//                    tempArray.append(company)
//                }
//            }
//        }
//
//        return tempArray
//    }
//
//    var shouldRefreshCache: Bool {
//        CacheDateManager.shared.compnayObjectsHaveExpired && allCompanies.isEmpty
//    }
//
//    func invalidateChache() {
//        CacheDateManager.shared.clearUpdateLastUpdatedDate(key: .companyObjectsLastUpdatedDate)
//    }
//
//    func loadCompanyFromCache(id: String) -> Company? {
//        if
//            let company = allCompanies.first(where: { $0.id == id }),
//            !CacheDateManager.shared.compnayObjectsHaveExpired {
//            return company
//        }
//
//        guard
//            let modelContext = modelContext else { return nil}
//
//        let companyDescriptor = FetchDescriptor<Company>(
//            predicate: #Predicate { $0.id == id },
//            sortBy: []
//        )
//
//        do {
//            let company = try modelContext.fetch(companyDescriptor).first
//            return company
//        } catch {
//            return nil
//        }
//    }
//
//    func saveCompaniesToCache(companies: [Company]) throws {
//        guard let modelContext = modelContext else { return }
//        do {
//            companies.forEach { modelContext.insert($0) }
//            try modelContext.save()
//            CacheDateManager.shared.updateLastUpdatedDate(key: .companyObjectsLastUpdatedDate)
//            loadCompanies()
//        } catch(let error) {
//            throw CompanyManagerError.saveCompaniesError(error)
//        }
//    }
//
//    func deleteCompaniesFromChache() {
//        guard let modelContext = modelContext else { return }
//        allCompanies.forEach { modelContext.delete($0)}
//        invalidateChache()
//        loadCompanies()
//    }
//
//    private func loadCompanies() {
//        guard let modelContext = modelContext else { return }
//
//        let companyDescriptor = FetchDescriptor<Company>(
//            predicate: nil,
//            sortBy: []
//        )
//
//        do {
//            allCompanies = try modelContext.fetch(companyDescriptor)
//        } catch(let error) {
//            // Log error
//            print(error.localizedDescription)
//        }
//    }
//
//    @MainActor
//    private func setupSwiftData() {
//        do {
//            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
//            let container = try ModelContainer(for: Company.self, configurations: configuration)
//            modelContainer = container
//
//            modelContext = container.mainContext
//            modelContext?.autosaveEnabled = true
//
//        } catch(let error) {
//            print(error.localizedDescription)
//        }
//    }
//
//    @MainActor
//    init(categoryFilter: CategoryManager = CategoryManager()) {
//        self.categoryFilter = categoryFilter
//        setupSwiftData() // Important this runs first!
//        loadCompanies()
//    }
//}


//@Observable
//class CompanyFilter: ObservableObject {
//
//    private (set) var allCompanies: [Company]
//    private (set) var categoryFilter: CategoryFilter
//
//    var filteredCompanies: [CompanyObject] {
//        if !categoryFilter.hasSelectedCategories {
//            return allCompanies
//        }
//
//        var tempArray = [Company]()
//        for category in categoryFilter.selctedCategories {
//            for company in allCompanies {
//                if company.category == category {
//                    tempArray.append(company)
//                }
//            }
//        }
//
//        return tempArray
//    }
//
//    func addCompany(company: Company) {
//        allCompanies.append(company)
//    }
//
//    func setCompanies(companies: [Company]) {
//        allCompanies = companies
//    }
//
//    init(comapnies: [Company] = [], categoryFilter: CategoryFilter = CategoryFilter()) {
//        self.categoryFilter = categoryFilter
//        self.allCompanies = comapnies
//    }
//}


//
//@Observable
//class CategoryManager: ObservableObject {
//    var categories: [Category]
//
//    var selctedCategories: [Category] = [Category]()
//
//    var hasSelectedCategories: Bool  {
//        !selctedCategories.isEmpty
//    }
//
//    func resetSelectedCategories() {
//        selctedCategories = []
//    }
//
//    func selectedCategoriesConatins(_ category: Category) -> Bool {
//        selctedCategories.contains(category)
//    }
//
//    func addToSelectedCategories(category: Category) {
//        selctedCategories.append(category)
//    }
//
//    func removeSelectedCategory(category: Category) {
//        selctedCategories.removeAll(where: { $0 == category })
//    }
//
//    func handleCategorySelection(category: Category) {
//        if selctedCategories.contains(category) {
//            removeSelectedCategory(category: category)
//        } else if !selctedCategories.contains(category) {
//            addToSelectedCategories(category: category)
//        }
//    }
//
//    init(categories: [Category] = Category.allCases) {
//        self.categories = categories
//    }
//
//}


@Observable
class CompanyManager: ObservableObject {

private (set) var allCompanies: [Company]
private (set) var categoryFilter: CategoryManager

var filteredCompanies: [Company] {
    if !categoryFilter.hasSelectedCategories {
        return allCompanies
    }

    var tempArray = [Company]()
    for category in categoryFilter.selctedCategories {
        for company in allCompanies {
            if company.category == category {
                tempArray.append(company)
            }
        }
    }

    return tempArray
}

func addCompany(company: Company) {
    allCompanies.append(company)
}

func setCompanies(companies: [Company]) {
    allCompanies = companies
}

init(comapnies: [Company] = [], categoryFilter: CategoryManager = CategoryManager()) {
    self.categoryFilter = categoryFilter
    self.allCompanies = comapnies
}
}
*/
