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
    var loadingState: CompanyProfileLoadingState { get set }
    var activityFeedViewModel: ActivityFeedViewViewModelType { get set }
    var companyProfileViewService: CompanyProfileViewServiceType { get set }
    func loadCompanyProfile(companyID: String) async
}

@Observable
class DevCompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var activityFeedViewModel: ActivityFeedViewViewModelType
    var companyProfileViewService: CompanyProfileViewServiceType
    var loadingState: CompanyProfileLoadingState

    init(
        activityFeedViewModel: ActivityFeedViewViewModelType,
        companyProfileViewService: CompanyProfileViewServiceType,
        loadingState: CompanyProfileLoadingState)
    {
        self.activityFeedViewModel = activityFeedViewModel
        self.companyProfileViewService = companyProfileViewService
        self.loadingState = loadingState
    }

    convenience init(loadingState: CompanyProfileLoadingState = .idle) {
        let activityFeedViewModel = DevCompanyActivityFeed()
        let companyProfileViewService = DevCompanyProfileViewService()
        self.init(
            activityFeedViewModel: activityFeedViewModel,
            companyProfileViewService: companyProfileViewService,
            loadingState: loadingState
        )
    }

    func loadCompanyProfile(companyID: String) async {
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
class CompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var activityFeedViewModel: ActivityFeedViewViewModelType
    var companyProfileViewService: CompanyProfileViewServiceType
    var loadingState: CompanyProfileLoadingState = .idle

    init() {
        self.activityFeedViewModel = CompanyActivityFeed(
            companyID: "ID", service: ActivityPostsService() // COMEBACK TO THIS
        )
        self.companyProfileViewService = CompanyProfileViewService()
    }

    func loadCompanyProfile(companyID: String) async {
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
class OfflineCompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = OfflineActivityFeed()
    var companyProfileViewService: CompanyProfileViewServiceType = OfflineCompanyProfileViewService()
    var loadingState: CompanyProfileLoadingState = .idle

    func loadCompanyProfile(companyID: String) async {
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
