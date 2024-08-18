//
//  CategoryHandlerType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/10/24.
//

import Foundation

@Observable
class CategoryFilter: ObservableObject {
    var categories: [Category]

    var selctedCategories: [Category] = [Category]()

    var hasSelectedCategories: Bool  {
        !selctedCategories.isEmpty
    }

    func resetSelectedCategories() {
        selctedCategories = []
    }

    func selectedCategoriesConatins(_ category: Category) -> Bool {
        selctedCategories.contains(category)
    }

    func addToSelectedCategories(category: Category) {
        selctedCategories.append(category)
    }

    func removeSelectedCategory(category: Category) {
        selctedCategories.removeAll(where: { $0 == category })
    }

    func handleCategorySelection(category: Category) {
        if selctedCategories.contains(category) {
            removeSelectedCategory(category: category)
        } else if !selctedCategories.contains(category) {
            addToSelectedCategories(category: category)
        }
    }

    init(categories: [Category] = Category.allCases) {
        self.categories = categories
    }

}

class ActivityPostsFilter: ObservableObject {
    var categoryFilter: CategoryFilter

    init(categoryFilter: CategoryFilter) {
        self.categoryFilter = categoryFilter
    }
}

class CompanyFilter: ObservableObject {

    private (set) var allCompanies: [CompanyObject]

    var categoryFilter: CategoryFilter

    var filteredCompanies: [CompanyObject] {
        allCompanies // For Now
    }

    var allCategories: [Category] {
        categoryFilter.categories
    }

    var selectedCategories: [Category] {
        categoryFilter.selctedCategories
    }

    func addCompany(company: CompanyObject) {
        allCompanies.append(company)
    }

    func addCompanies(companies: [CompanyObject]) {
        allCompanies.append(contentsOf: companies)
    }

    init(comapnies: [CompanyObject] = [], categoryFilter: CategoryFilter = CategoryFilter()) {
        self.categoryFilter = categoryFilter
        self.allCompanies = comapnies
    }
}
