//
//  NavigationCoordinator.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/5/24.
//

import Foundation
import SwiftUI

protocol NavigationCoordinatorType {
    var path: NavigationPath { get set }
    var companyProfileViewViewModel: CompanyProfileViewViewModelType { get set }
    func navigateToRoot()
    func navigateToCompanyPage(_ companyId: String)
}

@Observable
final class NavigationCoordinator: NavigationCoordinatorType {
    var path = NavigationPath()
    var companyProfileViewViewModel: CompanyProfileViewViewModelType = CompanyProfileViewViewModel()

    func navigateToRoot() {
        path.removeLast(path.count)
    }

    func navigateToCompanyPage(_ companyId: String) {
        path.append(Page.companyProfileView(companyID: companyId))
    }

    @ViewBuilder
    func buildPage(page: Page) -> some View  {
        switch page {
        case .companyProfileView(let id):
            CompanyProfileView(viewModel: companyProfileViewViewModel, companyID: id)
        }
    }
}

@Observable
final class DevNavigationCoordinator: NavigationCoordinatorType {
    var path = NavigationPath()
    var companyProfileViewViewModel: CompanyProfileViewViewModelType = DevCompanyProfileViewViewModel()

    func navigateToRoot() {
        path.removeLast(path.count)
    }

    func navigateToCompanyPage(_ companyId: String) {
        path.append(Page.companyProfileView(companyID: companyId))
    }

    @ViewBuilder
    func buildPage(page: Page) -> some View  {
        switch page {
        case .companyProfileView(let id):
            CompanyProfileView(viewModel: companyProfileViewViewModel, companyID: id)
        }
    }
}

@Observable
final class OfflineNavigationCoordinator: NavigationCoordinatorType {
    var path = NavigationPath()
    var companyProfileViewViewModel: CompanyProfileViewViewModelType = OfflineCompanyProfileViewViewModel()

    func navigateToRoot() {
        path.removeLast(path.count)
    }

    func navigateToCompanyPage(_ companyId: String) {
        path.append(Page.companyProfileView(companyID: companyId))
    }

    @ViewBuilder
    func buildPage(page: Page) -> some View  {
        switch page {
        case .companyProfileView(let id):
            CompanyProfileView(viewModel: companyProfileViewViewModel, companyID: id)
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
