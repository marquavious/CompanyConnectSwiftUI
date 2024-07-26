//
//  ActivityFeedViewJSONResponse.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/23/24.
//

import Foundation

struct ActivityFeedJSONResponse: Codable {
    let page: Int
    let activityPosts: [ActvityPost]
}
