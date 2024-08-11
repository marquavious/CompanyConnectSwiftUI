//
//  CategoryHandlerType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/10/24.
//

import Foundation

protocol CategoryHandlerType {
    var categories: [Category] { get set }
    var selctedCategories: [Category] { get set }
    var hasSelectedCategories: Bool { get }
    func resetSelectedCategories()
    func addToSelectedCategories(category: Category)
    func removeSelectedCategory(category: Category)
    func handleCategorySelection(category: Category)
}

class CategoryHandler: CategoryHandlerType {
    var categories: [Category] = Category.allCases

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

}
