//
//  TweetGenerator.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct TweetGenerator {

    static func generateRandomTweets() -> [ActvityPost] {

        var ackposts = [ActvityPost]()

        for _ in (1..<50) {

            let company = CompanyObject.createFakeComapnyList().shuffled().randomElement()!
            let companyPostData = CompanyData(
                id: company.id,
                name: company.orginizationName,
                logoUrl: company.coverImageUrl
            )
            let tamMember = company.team.randomElement()!

            let post = ActvityPost(
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

    static func generateRandomTweetsFrom(company: CompanyObject) -> [ActvityPost] {

        var ackposts = [ActvityPost]()

        for _ in (1..<50) {

            let tamMember = company.team.shuffled().randomElement()!
            let companyPostData = CompanyData(
                id: company.id,
                name: company.orginizationName,
                logoUrl: company.coverImageUrl
            )

            let post = ActvityPost(
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

/*
    static func returnStructuredTweetList() -> [ActvityPost] {

        func returnCompany() -> CompanyObject {
           return CompanyObject.createFakeComapnyList().randomElement()!
        }

        return [
            ActvityPost(
                id: UUID().uuidString,
                companyName: returnCompany(),
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 1
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: returnCompany(),
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaDataType.createFakePhotoMedia(),
                hourAgoPosted: 1
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 2
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 2
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaDataType.createFakePhotoMedia(),
                hourAgoPosted: 3
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 1
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 3
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 3
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 4
            ),

            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: .photoCarousel(
                    [
                        "imageUrl 1",
                        "imageUrl 2",
                        "imageUrl 3",
                        "imageUrl 4"
                    ]
                ),
                hourAgoPosted: 4
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: "We're $200 away from our fundrasing goal! Thank you all for the support!",
                media:.donationProgress(250, 500),
                hourAgoPosted: 4
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 5
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaDataType.createFakePhotoMedia(),
                hourAgoPosted: 5
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 5
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media:  nil ,//.video("move-8"),
                hourAgoPosted: 5
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaDataType.createFakePhotoMedia(),
                hourAgoPosted: 6
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 6
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil ,//.video("move-2"),
                hourAgoPosted: 7
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 7
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaDataType.createFakePhotoMedia(),
                hourAgoPosted: 8
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 8
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(), 
                media: MediaDataType.generateRandomMedia(),
                hourAgoPosted: 8
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaDataType.createFakePhotoMedia(),
                hourAgoPosted: 9
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil ,//.video("move-1"),
                hourAgoPosted: 9
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 9
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 9
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 10
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: .photoCarousel(
                    [
                        "imageUrl 1",
                        "imageUrl 2",
                        "imageUrl 3",
                        "imageUrl 4"
                    ]
                ),
                hourAgoPosted: 10
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: "We're $200 away from our fundrasing goal! Thank you all for the support! ",
                media:.donationProgress(250, 500),
                hourAgoPosted: 10
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 11
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaDataType.createFakePhotoMedia(),
                hourAgoPosted: 11
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 11
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil, //.video("move-6"),
                hourAgoPosted: 12
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaDataType.createFakePhotoMedia(),
                hourAgoPosted: 12
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 13
            ),
            ActvityPost(
                id: UUID().uuidString,
                companyName: CompanyObject.createFakeComapnyList().randomElement()!,
                posterName: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 13
            )
        ]
    }
}
*/
