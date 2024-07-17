//
//  ActvityPost.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct ActvityPost: Hashable, Identifiable {
    static func == (lhs: ActvityPost, rhs: ActvityPost) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    let id = UUID()
    let company: CompanyObject
    let poster: TeamMember?
    let caption: String?
    let media: Media?
    let hourAgoPosted: Int

    static func makeFakeActivityPosts() -> [ActvityPost] {

        return TweetGenerator.generateRandomTweets()

    }
}
