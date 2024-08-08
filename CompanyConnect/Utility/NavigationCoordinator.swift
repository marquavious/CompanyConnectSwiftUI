//
//  NavigationCoordinator.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/5/24.
//

import Foundation
import SwiftUI

class NavigationCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func navigateToRoot() {
        path.removeLast(path.count)
    }

    func navigateToCompanyPage(_ companyId: String) {
        path.append(Page.companyProfileView(companyID: companyId))
    }

    @ViewBuilder
    func buildPage(page: Page) -> some View {
        fatalError("Must Override")
    }
}

@Observable
final class ProdNavigationCoordinator: NavigationCoordinator {
    @ViewBuilder
    func buildPage(page: Page) -> some View  {
        switch page {
        case .companyProfileView(let id):
            CompanyProfileView(viewModel: CompanyProfileViewViewModel(id: id))
        }
    }
}

@Observable
final class DevNavigationCoordinator: NavigationCoordinator {
    @ViewBuilder
    func buildPage(page: Page) -> some View  {
        switch page {
        case .companyProfileView:
            CompanyProfileView(viewModel: DevCompanyProfileViewViewModel())
        }
    }
}

@Observable
final class OfflineNavigationCoordinator: NavigationCoordinator {
    @ViewBuilder
    func buildPage(page: Page) -> some View  {
        switch page {
        case .companyProfileView:
            CompanyProfileView(viewModel: OfflineCompanyProfileViewViewModel())
        }
    }
}

enum Page: Identifiable, Hashable {
    case companyProfileView(companyID: String)
    
    var id: String {
        switch self {
        case .companyProfileView:
            "compnay_profile"
        }
    }
}
