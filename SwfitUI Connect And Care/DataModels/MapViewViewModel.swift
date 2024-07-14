import Foundation
import SwiftUI

@Observable
class MapViewViewModel: ObservableObject {

    init() { }

    var companies: [CompanyObject] = CompanyObject.ceateFakeComapnyList()
    var categories: [Category] = [.community,.healthcare, .environmental, .education,.womensRights,.veterans, .humanRights,.indigenousRights]

    var selctedCategories = [Category]()

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

    func handleSelectedCategory(_ category: Category) {
        if selctedCategories.contains(category) {
            selctedCategories.removeAll(where: { $0 == category })
        } else if !selctedCategories.contains(category) {
            selctedCategories.append(category)
        } else {
            print("Interesting")
        }
    }
}
