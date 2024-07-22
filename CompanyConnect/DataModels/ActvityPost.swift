//
//  ActvityPost.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct ActvityPost: Codable, Hashable, Identifiable {
    
    let id: String
    let company: CompanyObject
    let poster: TeamMember?
    let caption: String?
    let media: MediaData?
    let hourAgoPosted: Int

    static func == (lhs: ActvityPost, rhs: ActvityPost) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension ActvityPost {
    static func createFakeActivityPost(media: MediaData? = nil, poster: TeamMember? = nil) -> ActvityPost {
        return ActvityPost(
            id: UUID().uuidString, 
            company: CompanyObject.createFakeCompanyObject(),
            poster: poster,
            caption: "Here is a very informative post",
            media: media,
            hourAgoPosted: Int.random(in: 1..<20)
        )
    }

    static func createFakeActivityPostForCompany(company: CompanyObject) -> ActvityPost {
        ActvityPost.createFakeActivityPost(
            media: Bool.random() ? MediaData.generateRandomMedia() : nil,
            poster:  Bool.random() ? (company.team.randomElement() ?? nil) : nil
        )
    }
}
