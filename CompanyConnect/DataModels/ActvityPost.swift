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
    let poster: PosterData?
    let media: Media?
    let company: CompanyActivityPostData
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
        poster: PosterData? = (Bool.random() ? nil : PosterData.generateRandomActvityPostPoster())
    ) -> ActvityPost {
        let company = CompanyObject.createFakeComapnyList().randomElement()!
        let companyPostData = CompanyActivityPostData(
            id: company.id,
            name: company.orginizationName,
            logoUrl: company.coverImageUrl
        )
        return ActvityPost(
            id: UUID().uuidString,
            caption: StringGenerator.generateRandomActivityString(),
            imageUrl: "imgUrl",
            poster: poster,
            media: media, 
            company: companyPostData,
            date: Date.randomWithin24Hours()
        )
    }

    static func createFakeActivityPostForCompany(company: CompanyObject) -> ActvityPost {
        ActvityPost.createFakeActivityPost(
            media: Bool.random() ? Media.generateRandomMedia() : nil,
            poster:  Bool.random() ? PosterData.generateRandomActvityPostPoster() : nil
        )
    }
}

struct CompanyActivityPostData: Codable {
    let id: String
    let name: String
    let logoUrl: String
}

struct PosterData: Codable {
    let id: String
    let name: String
    let imageUrl: String
}

extension PosterData {
    static func generateRandomActvityPostPoster() -> PosterData {
        PosterData(
            id: UUID().uuidString,
            name: "John Doe",
            imageUrl: "imageUrl"
        )
    }
}
