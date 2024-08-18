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

@Observable
class ActivityPostsFilter: ObservableObject {

    private (set) var allPosts: [ActivityPost]
    private (set) var categoryFilter: CategoryFilter

    var filteredPosts: [ActivityPost] {
        if !categoryFilter.hasSelectedCategories {
            return allPosts
        }

        var tempArray = [ActivityPost]()
        for category in categoryFilter.selctedCategories {

            for post in allPosts {
                if post.company.category == category {
                    tempArray.append(post)
                }
            }
        }

        return tempArray.sorted { post1, post2 in
            post1.date < post2.date
        }
    }

    func setPosts(posts: [ActivityPost]) {
        allPosts = posts
    }

    init(posts: [ActivityPost] = [], categoryFilter: CategoryFilter = CategoryFilter()) {
        self.categoryFilter = categoryFilter
        self.allPosts = posts
    }
}

@Observable
class CompanyFilter: ObservableObject {

    private (set) var allCompanies: [CompanyObject]
    private (set) var categoryFilter: CategoryFilter

    var filteredCompanies: [CompanyObject] {
        if !categoryFilter.hasSelectedCategories {
            return allCompanies
        }

        var tempArray = [CompanyObject]()
        for category in categoryFilter.selctedCategories {
            for company in allCompanies {
                if company.category == category {
                    tempArray.append(company)
                }
            }
        }

        return tempArray
    }

    func addCompany(company: CompanyObject) {
        allCompanies.append(company)
    }

    func setCompanies(companies: [CompanyObject]) {
        allCompanies = companies
    }

    init(comapnies: [CompanyObject] = [], categoryFilter: CategoryFilter = CategoryFilter()) {
        self.categoryFilter = categoryFilter
        self.allCompanies = comapnies
    }
}
