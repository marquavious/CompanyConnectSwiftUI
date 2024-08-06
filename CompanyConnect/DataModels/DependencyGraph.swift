//
//  DependencyGraph.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation

protocol DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType { get set }
    var mapViewViewModel: MapViewViewModelType { get set }
    var donationsViewViewModel: DonationsViewViewModelType { get set }
    var companyProfileViewViewModel: CompanyProfileViewViewModelType { get set }
}

class DependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = DevHomeTabActivityFeed() // Change
    var mapViewViewModel: MapViewViewModelType = OfflineMapViewViewModel() // Change
    var donationsViewViewModel: DonationsViewViewModelType = DevDonationsViewViewModel()
    var companyProfileViewViewModel: CompanyProfileViewViewModelType = OfflineCompanyProfileViewViewModel() // Change
}

class OfflineDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = OfflineActivityFeed()
    var mapViewViewModel: MapViewViewModelType = OfflineMapViewViewModel()
    var donationsViewViewModel: DonationsViewViewModelType = OfflineDonationsViewViewModel()
    var companyProfileViewViewModel: CompanyProfileViewViewModelType = OfflineCompanyProfileViewViewModel()
}

class IntegratedDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = OfflineActivityFeed() // Change
    var mapViewViewModel: MapViewViewModelType = OfflineMapViewViewModel() // Change
    var donationsViewViewModel: DonationsViewViewModelType = DevDonationsViewViewModel()
    var companyProfileViewViewModel: CompanyProfileViewViewModelType = OfflineCompanyProfileViewViewModel() // Change
}

class DevlopmentDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = DevHomeTabActivityFeed()
    var mapViewViewModel: MapViewViewModelType = DevMapViewViewModel()
    var donationsViewViewModel: DonationsViewViewModelType = DevDonationsViewViewModel()
    var companyProfileViewViewModel: CompanyProfileViewViewModelType = DevCompanyProfileViewViewModel() // Change
}
