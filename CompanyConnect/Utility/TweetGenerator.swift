//
//  TweetGenerator.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct TweetGenerator {

    static func generateRandomTweets() -> [Post] {

        var ackposts = [Post]()

        for _ in (1..<50) {

            let company = Company.createFakeComapnyList().shuffled().randomElement()!
            let companyPostData = CompanyData(
                id: company.id,
                name: company.orginizationName,
                logoUrl: company.coverImageUrl,
                category: company.category
            )
            let tamMember = company.team.randomElement()!

            let post = Post(
                id: UUID().uuidString,
                caption: StringGenerator.generateRandomActivityString(),
                imageUrl: "imge_url",
                poster: PosterData(
                    id: tamMember.id,
                    name: tamMember.name,
                    imageUrl: "imge_url"
                ),
                media: generateRandomMeda().shuffled().randomElement()!,
                company: companyPostData,
                date: Date.randomWithin24Hours()
            )

            ackposts.append(post)
        }

        for i in 0...ackposts.count {
            if i < 1, i > ackposts.count - 1 {
                let post = ackposts[i]
                let previousPost = ackposts[i - 1]

                if post.media?.type == previousPost.media?.type {
                    ackposts.remove(at: i)
                }
            }
        }

        return ackposts.sorted { $0.date < $1.date }
    }

    static func generateRandomTweetsFrom(company: Company) -> [Post] {

        var ackposts = [Post]()

        for _ in (1..<50) {

            let tamMember = company.team.shuffled().randomElement()!
            let companyPostData = CompanyData(
                id: company.id,
                name: company.orginizationName,
                logoUrl: company.coverImageUrl,
                category: company.category
            )

            let post = Post(
                id: UUID().uuidString,
                caption: StringGenerator.generateRandomActivityString(),
                imageUrl: "imge_url",
                poster: PosterData(
                    id: tamMember.id,
                    name: tamMember.name,
                    imageUrl: "imge_url"
                ),
                media: generateRandomMeda().shuffled().randomElement()!,
                company: companyPostData,
                date: Date.randomWithin24Hours()
            )

            ackposts.append(post)
        }

        for i in 0...ackposts.count {
            if i < 1, i > ackposts.count - 1 {
                let post = ackposts[i]
                let previousPost = ackposts[i - 1]

                if post.media?.type == previousPost.media?.type {
                    ackposts.remove(at: i)
                }
            }
        }

        return ackposts.sorted { $0.date < $1.date }
    }

    static func generateRandomMeda() -> [Media?] {

        var array = [
            Bool.random() ? nil: ( Bool.random() ? nil : Media.createDonationProgressMedia()),
            Bool.random() ? nil: Media.createFakePhotoCarouselMedia() ,
            Bool.random() ? nil: Media.createFakePhotoMedia(),
            nil,
            nil,
            nil
        ]

        for i in 0...array.count {
            if i < 1, i > array.count {
                if let post = array[i], let previousPost = array[i - 1] {
                    if post.type == previousPost.type {
                        array.remove(at: i)
                    }
                }
            }
        }

        return array
    }
}
