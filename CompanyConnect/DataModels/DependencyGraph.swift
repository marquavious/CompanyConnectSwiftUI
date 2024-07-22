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
}

class DependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = DevHomeTabActivityFeed() // Change
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService()) // Change
}

class OfflineDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = OfflineActivityFeed(service: OfflinePostsService(postCount: 100))
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService())
}

class IntegratedDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = OfflineActivityFeed(service: OfflinePostsService(postCount: 100)) // Change
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService()) // Change
}

class DevlopmentDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = DevHomeTabActivityFeed()
    var mapViewViewModel:  MapViewViewModelType = DevMapViewViewModel()
}
