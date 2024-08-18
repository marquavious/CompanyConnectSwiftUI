//
//  CompanyManager.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/18/24.
//

import Foundation

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
