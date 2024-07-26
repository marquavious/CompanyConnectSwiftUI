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
}

class DependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = DevHomeTabActivityFeed() // Change
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService()) // Change
    var donationsViewViewModel: DonationsViewViewModelType = DevDonationsViewViewModel()
}

class OfflineDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = OfflineActivityFeed(service: OfflineActivityPostsService())
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService())
    var donationsViewViewModel: DonationsViewViewModelType = DevDonationsViewViewModel()
}

class IntegratedDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = OfflineActivityFeed(service: OfflineActivityPostsService()) // Change
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService()) // Change
    var donationsViewViewModel: DonationsViewViewModelType = DevDonationsViewViewModel()
}

class DevlopmentDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = DevHomeTabActivityFeed()
    var mapViewViewModel:  MapViewViewModelType = DevMapViewViewModel()
    var donationsViewViewModel: DonationsViewViewModelType = DevDonationsViewViewModel()
}
