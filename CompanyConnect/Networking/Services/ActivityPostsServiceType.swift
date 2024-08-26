//
//  ActivityPostsServiceType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/11/24.
//

import Foundation
import Factory
import FirebaseFirestore

extension Container {
    var activityServiceType: Factory<ActivityPostsServiceType> {
        switch AppConfig.shared.enviorment {
        case .production:
            self { FirebaseActivityPostsService() }
        case .offline:
            self { OfflineActivityPostsService() }
        case .development:
            self { DevActivityPostsService() }
        }
    }
}

protocol ActivityPostsServiceType: HTTPDataDownloader {
    func getPosts() async throws -> ActivityFeedJSONResponse
    func getPostsFromCompanyWithID(_ id: String) async throws -> ActivityFeedJSONResponse
}

@Observable
class FirebaseActivityPostsService: ActivityPostsServiceType {
    @MainActor
    func getPosts() async throws -> ActivityFeedJSONResponse {
        let snapshot = try await Firestore
            .firestore()
            .collection(FirebaseDataStoreRoute.activityPosts.route)
            .getDocuments()

        let flattenedArray = try snapshot.documents.compactMap { document in
            try document.data(as: Post.self)
        }

        return ActivityFeedJSONResponse(activityPosts: flattenedArray)
    }

    @MainActor
    func getPostsFromCompanyWithID(_ id: String) async throws -> ActivityFeedJSONResponse {
        return try await getData(as: ActivityFeedJSONResponse.self, from: URLBuilder.companyFeed(companyID: id).url)
    }
}

@Observable
class DevActivityPostsService: ActivityPostsServiceType {
    @MainActor
    func getPosts() async throws -> ActivityFeedJSONResponse {
        ActivityFeedJSONResponse(activityPosts: [Post.createFakeActivityPost(), Post.createFakeActivityPost(), Post.createFakeActivityPost()])
    }

    @MainActor
    func getPostsFromCompanyWithID(_ id: String) async throws -> ActivityFeedJSONResponse {
        ActivityFeedJSONResponse(
            activityPosts: [Post.createFakeActivityPostForCompany(company: Company.createFakeCompanyObject())]
        )
    }
}

@Observable
class OfflineActivityPostsService: ActivityPostsServiceType {
    @MainActor
    func getPosts() async throws -> ActivityFeedJSONResponse {
        return try await getData(as: ActivityFeedJSONResponse.self, from: URLBuilder.activityFeed.url)
    }

    @MainActor
    func getPostsFromCompanyWithID(_ id: String) async throws -> ActivityFeedJSONResponse {
        return try await getData(as: ActivityFeedJSONResponse.self, from: URLBuilder.companyFeed(companyID: id).url)
    }
}

/* Example to set data
for post in response.activityPosts {
    try Firestore
        .firestore()
        .collection(FirebaseDataStoreRoute.activityPosts.route)
        .document(post.id)
        .setData(from: post)
}
*/
