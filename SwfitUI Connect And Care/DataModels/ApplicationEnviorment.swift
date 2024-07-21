//
//  ApplicationEnviorment.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation

enum ApplicationEnviorment: String {

    case production = "PRODUCTION"
    case offline = "OFFLINE"
    case integrated = "INTEGRATED"
    case development = "DEVELOPMENT"

    var activityFeedViewModel: ActivityFeedViewViewModelType {
        switch self {
        case .production:
            // For Now
            FakeHomeTabActivityFeed()
        case .offline:
            StubbedActivityFeed(service: OfflinePostsService(postCount: 50))
        case .integrated:
            StubbedActivityFeed(service: OfflinePostsService(postCount: 50))
        case .development:
            FakeHomeTabActivityFeed()
        }
    }

    var mapViewViewModel: MapViewViewModelType {
        switch self {
        case .production:
            // For Now
            OfflineMapViewViewModel(mapServiceType: OfflineMapService())
        case .offline:
            OfflineMapViewViewModel(mapServiceType: OfflineMapService())
        case .integrated:
            OfflineMapViewViewModel(mapServiceType: OfflineMapService())
        case .development:
            FakeMapViewViewModel()
        }
    }
}
