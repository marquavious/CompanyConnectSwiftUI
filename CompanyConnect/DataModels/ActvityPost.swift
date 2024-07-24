//
//  ActvityPost.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct ActvityPost: Codable, Hashable, Identifiable {

    let id: String
    let caption: String?
    let imageUrl: String
    let poster: ActvityPostPoster?
    let media: Media?
    let company: CompanyObject
    let date: Date

    static func == (lhs: ActvityPost, rhs: ActvityPost) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension ActvityPost {
    static func createFakeActivityPost(
        media: Media? = (Bool.random() ? nil : Media.generateRandomMedia()),
        poster: ActvityPostPoster? = (Bool.random() ? nil : ActvityPostPoster.generateRandomActvityPostPoster())
    ) -> ActvityPost {
        let company = CompanyObject.createFakeComapnyList().randomElement()!
        return ActvityPost(
            id: UUID().uuidString,
            caption: StringGenerator.generateRandomActivityString(),
            imageUrl: "imgUrl",
            poster: poster,
            media: media, 
            company: company,
            date: Date.randomWithin24Hours()
        )
    }

    static func createFakeActivityPostForCompany(company: CompanyObject) -> ActvityPost {
        ActvityPost.createFakeActivityPost(
            media: Bool.random() ? Media.generateRandomMedia() : nil,
            poster:  Bool.random() ? ActvityPostPoster.generateRandomActvityPostPoster() : nil
        )
    }
}

struct ActvityPostPoster: Codable {
    let id: String
    let name: String
    let badgeImageUrl: String
}

extension ActvityPostPoster {
    static func generateRandomActvityPostPoster() -> ActvityPostPoster {
        ActvityPostPoster(
            id: UUID().uuidString,
            name: "John Doe",
            badgeImageUrl: "imageUrl"
        )
    }
}
