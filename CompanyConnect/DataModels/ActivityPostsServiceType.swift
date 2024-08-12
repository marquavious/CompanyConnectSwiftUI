//
//  ActivityPostsServiceType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/11/24.
//

import Foundation

protocol ActivityPostsServiceType: HTTPDataDownloader {
    func getPosts() async throws -> ActivityFeedJSONResponse
}

@Observable
class ActivityPostsService: ActivityPostsServiceType {
    @MainActor
    func getPosts() async throws -> ActivityFeedJSONResponse {
        return try await getData(as: ActivityFeedJSONResponse.self, from: URLBuilder.activityFeed.url)
    }
}

@Observable
class DevActivityPostsService: ActivityPostsServiceType {
    @MainActor
    func getPosts() async throws -> ActivityFeedJSONResponse {
        return try await getData(as: ActivityFeedJSONResponse.self, from: URLBuilder.activityFeed.url)
    }
}

@Observable
class OfflineActivityPostsService: ActivityPostsServiceType {
    @MainActor
    func getPosts() async throws -> ActivityFeedJSONResponse {
        return try await getData(as: ActivityFeedJSONResponse.self, from: URLBuilder.activityFeed.url)
    }
}
