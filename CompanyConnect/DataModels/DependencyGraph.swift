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
    var activityFeedViewModel: ActivityFeedViewViewModelType = FakeHomeTabActivityFeed()
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService())
}

class OfflineDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = StubbedActivityFeed(service: OfflinePostsService(postCount: 100))
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService())
}

class IntegratedDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = StubbedActivityFeed(service: OfflinePostsService(postCount: 100))
    var mapViewViewModel:  MapViewViewModelType = OfflineMapViewViewModel(mapServiceType: OfflineMapService())
}

class DevlopmentDependencyGraph: DependencyGraphType {
    var activityFeedViewModel: ActivityFeedViewViewModelType = FakeHomeTabActivityFeed()
    var mapViewViewModel:  MapViewViewModelType = FakeMapViewViewModel()
}
