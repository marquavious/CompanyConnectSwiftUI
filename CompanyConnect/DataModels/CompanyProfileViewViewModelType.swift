//
//  CompanyProfileViewViewModelType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/3/24.
//

import Foundation

// I migt have to start merging these loading states
enum CompanyProfileLoadingState: Equatable {

    case idle
    case loading
    case fetched(CompanyObject)
    case error(Error)

    static func == (lhs: CompanyProfileLoadingState, rhs: CompanyProfileLoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.fetched, .fetched):
            true
        case let (.error(lhsError), .error(rhsError)):
            lhsError.localizedDescription == rhsError.localizedDescription
        default:
            false
        }
    }
}

protocol CompanyProfileViewViewModelType {
    var companyID: String { get set }
    var loadingState: CompanyProfileLoadingState { get set }
    var activityFeedViewModel: ActivityFeedViewViewModelType { get set }
    var companyProfileViewService: CompanyProfileViewServiceType { get set }
    func loadCompanyProfile() async
}

@Observable
class DevCompanyProfileViewViewModel: CompanyProfileViewViewModelType, ObservableObject {
    var companyID: String
    var activityFeedViewModel: ActivityFeedViewViewModelType
    var companyProfileViewService: CompanyProfileViewServiceType
    var loadingState: CompanyProfileLoadingState

    init(
        id: String,
        activityFeedViewModel: ActivityFeedViewViewModelType,
        companyProfileViewService: CompanyProfileViewServiceType,
        loadingState: CompanyProfileLoadingState)
    {
        self.companyID = id
        self.activityFeedViewModel = activityFeedViewModel
        self.companyProfileViewService = companyProfileViewService
        self.loadingState = loadingState
    }

    convenience init(loadingState: CompanyProfileLoadingState = .idle) {
        let activityFeedViewModel = DevCompanyActivityFeed()
        let companyProfileViewService = DevCompanyProfileViewService()
        self.init(
            id: "Doesn't Matter",
            activityFeedViewModel: activityFeedViewModel,
            companyProfileViewService: companyProfileViewService,
            loadingState: loadingState
        )
    }

    func loadCompanyProfile() async {
        loadingState = .loading
        do {
            let companyResponse = try await companyProfileViewService.getCompnayInfo(companyID: companyID)
            loadingState = .fetched(companyResponse.companyObject)
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
               nsError.code == NSURLErrorCancelled {
                //Handle cancellation
            } else {
                loadingState = .error(error)
            }
        }
    }

}

@Observable
class CompanyProfileViewViewModel: CompanyProfileViewViewModelType, ObservableObject {
    var companyID: String
    var activityFeedViewModel: ActivityFeedViewViewModelType
    var companyProfileViewService: CompanyProfileViewServiceType
    var loadingState: CompanyProfileLoadingState = .idle

    init(id: String) {
        self.companyID = id
        self.activityFeedViewModel = CompanyActivityFeed(
            companyID: id, service: ActivityPostsService() // COMEBACK TO THIS
        )
        self.companyProfileViewService = CompanyProfileViewService()
    }

    func loadCompanyProfile() async {
        loadingState = .loading
        do {
            let companyResponse = try await companyProfileViewService.getCompnayInfo(companyID: companyID)
            loadingState = .fetched(companyResponse.companyObject)
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
               nsError.code == NSURLErrorCancelled {
                //Handle cancellation
                loadingState = .error(error)
            } else {
                loadingState = .error(error)
            }
        }
    }

}

@Observable
class OfflineCompanyProfileViewViewModel: CompanyProfileViewViewModelType, ObservableObject {
    var companyID: String = "ID"
    var activityFeedViewModel: ActivityFeedViewViewModelType = OfflineActivityFeed()
    var companyProfileViewService: CompanyProfileViewServiceType = OfflineCompanyProfileViewService()
    var loadingState: CompanyProfileLoadingState = .idle

    func loadCompanyProfile() async {
        loadingState = .loading
        do {
            let companyResponse = try await companyProfileViewService.getCompnayInfo(companyID: companyID)
            loadingState = .fetched(companyResponse.companyObject)
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
               nsError.code == NSURLErrorCancelled {
                //Handle cancellation
            } else {
                loadingState = .error(error)
            }
        }
    }
}
