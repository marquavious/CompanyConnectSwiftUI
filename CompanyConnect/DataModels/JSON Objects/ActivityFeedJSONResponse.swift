//
//  ActivityFeedJSONResponse.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/22/24.
//

import Foundation

struct ActivityFeedJSONResponse: Codable {
    let activityPosts: [ActvityPost]
}

struct CompanyProfileViewJSONResponse: Codable {
    let companyObjct: CompanyObject
    let teamMemberIds: [String]
    let projectIds: [String]
}
