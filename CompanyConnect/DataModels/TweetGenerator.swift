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
            let tamMember = [TeamMember.generateRandomTeamList().shuffled().randomElement()]

            let post = ActvityPost(
                company: company,
                poster: Bool.random() ? tamMember.randomElement()! : nil,
                caption: StringGenerator.generateRandomActivityString(),
                media:  generateRandomMeda().shuffled().randomElement()!,
                hourAgoPosted: Int.random(in: 1...19)
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

        return ackposts.sorted { $0.hourAgoPosted < $1.hourAgoPosted }
    }

    static func generateRandomTweetsFrom(company: CompanyObject) -> [ActvityPost] {

        var ackposts = [ActvityPost]()

        for _ in (1..<50) {

            let tamMember = [company.team.shuffled().randomElement()]

            let post = ActvityPost(
                company: company,
                poster: Bool.random() ? tamMember.randomElement()! : nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: generateRandomMeda().shuffled().randomElement()!,
                hourAgoPosted: Int.random(in: 1...19)
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

        return ackposts.sorted { $0.hourAgoPosted < $1.hourAgoPosted }
    }

    static func generateRandomMeda() -> [MediaData?] {

        var array = [
            Bool.random() ? nil: ( Bool.random() ? nil : MediaData.createDonationProgressMedia()),
            Bool.random() ? nil: MediaData.createFakePhotoCarouselMedia() ,
            Bool.random() ? nil: MediaData.createFakePhotoMedia(),
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

    static func returnStructuredTweetList() -> [ActvityPost] {

        func returnCompany() -> CompanyObject {
           return CompanyObject.createFakeComapnyList().randomElement()!
        }

        return [
            ActvityPost(
                company: returnCompany(),
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 1
            ),
            ActvityPost(
                company: returnCompany(),
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaData.createFakePhotoMedia(),
                hourAgoPosted: 1
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 2
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 2
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaData.createFakePhotoMedia(),
                hourAgoPosted: 3
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 1
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 3
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 3
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 4
            ),

            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: .photoCarousel(
                    [
                        IdentifiableImage.createFakeIdentifiableImage(),
                        IdentifiableImage.createFakeIdentifiableImage(),
                        IdentifiableImage.createFakeIdentifiableImage(),
                        IdentifiableImage.createFakeIdentifiableImage()
                    ]
                ),
                hourAgoPosted: 4
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: "We're $200 away from our fundrasing goal! Thank you all for the support!",
                media:.donationProgress(250, 500),
                hourAgoPosted: 4
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 5
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaData.createFakePhotoMedia(),
                hourAgoPosted: 5
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 5
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media:  nil ,//.video("move-8"),
                hourAgoPosted: 5
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaData.createFakePhotoMedia(),
                hourAgoPosted: 6
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 6
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil ,//.video("move-2"),
                hourAgoPosted: 7
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 7
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaData.createFakePhotoMedia(),
                hourAgoPosted: 8
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 8
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(), 
                media: MediaData.generateRandomMedia(),
                hourAgoPosted: 8
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaData.createFakePhotoMedia(),
                hourAgoPosted: 9
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil ,//.video("move-1"),
                hourAgoPosted: 9
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 9
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 9
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 10
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: .photoCarousel(
                    [
                        IdentifiableImage.createFakeIdentifiableImage(),
                        IdentifiableImage.createFakeIdentifiableImage(),
                        IdentifiableImage.createFakeIdentifiableImage(),
                        IdentifiableImage.createFakeIdentifiableImage()
                    ]
                ),
                hourAgoPosted: 10
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: "We're $200 away from our fundrasing goal! Thank you all for the support! ",
                media:.donationProgress(250, 500),
                hourAgoPosted: 10
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 11
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaData.createFakePhotoMedia(),
                hourAgoPosted: 11
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 11
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil, //.video("move-6"),
                hourAgoPosted: 12
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: MediaData.createFakePhotoMedia(),
                hourAgoPosted: 12
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: TeamMember.generateRandomTeamList().randomElement()!,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 13
            ),
            ActvityPost(
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                poster: nil,
                caption: StringGenerator.generateRandomActivityString(),
                media: nil,
                hourAgoPosted: 13
            )
        ]
    }
}
