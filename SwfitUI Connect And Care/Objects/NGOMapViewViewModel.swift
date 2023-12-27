import Foundation
import SwiftUI

@Observable
class NGOMapViewViewModel: ObservableObject {

    init() { }

    var companies: [CompanyObject] = CompanyObject.ceateFakeComapnyList()
    var categories: [Category] = Category.createCategoryList().sorted { $0.name < $1.name }

    var selctedCategories = [Category]() {
        didSet {
            print(selctedCategories.map { $0.name })
        }
    }

    var hasSelected: Bool {
        return !selctedCategories.isEmpty
    }

    var presentedCompanies: [CompanyObject] {
        if selctedCategories.isEmpty {
            return companies
        }


        var tempArray = [CompanyObject]()
        for category in selctedCategories {

            for company in companies {
                if company.category == category {
                    tempArray.append(company)
                }
            }
        }

        return tempArray
    }

    func resetSelectedCategories() {
        selctedCategories = []
    }

}
