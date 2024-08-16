//
//  CategoryHandlerType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/10/24.
//

import Foundation

class CategoryHandler {
    var categories: [Category]

    var selctedCategories: [Category] = [Category]()

    var hasSelectedCategories: Bool  {
        selctedCategories.isEmpty
    }

    func resetSelectedCategories() {
        selctedCategories = []
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
