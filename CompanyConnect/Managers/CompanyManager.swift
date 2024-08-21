//
//  CompanyManager.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/18/24.
//

import Foundation
import SwiftData

enum CompanyManagerError: Error {
    case saveCompaniesError(Error)
    case setupSwiftDataError(Error)
    case loadCompaniesError(Error)
}

@Observable
class CompanyManager: ObservableObject {

    private (set) var allCompanies = [Company]()
    private (set) var categoryFilter: CategoryManager

    var modelContext: ModelContext? = nil
    var modelContainer: ModelContainer? = nil

    var filteredCompanies: [Company] {
        if !categoryFilter.hasSelectedCategories {
            return allCompanies
        }

        // TODO: - Optimize
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

    var shouldLoadCompanies: Bool {
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

    func deleteCompaniesFromChache() {
        guard let modelContext = modelContext else { return }
        allCompanies.forEach { modelContext.delete($0)}
        invalidateChache()
        loadCompanies()
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

    @MainActor
    init(categoryFilter: CategoryManager = CategoryManager()) {
        self.categoryFilter = categoryFilter
        setupSwiftData() // Important this runs first!
        loadCompanies()
    }
}
