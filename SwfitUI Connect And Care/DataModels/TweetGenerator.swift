//
//  TweetGenerator.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct TweetGenerator {

    static func generateRandomTweets() -> [ActvityPost] {

        var ackposts = [ActvityPost]()

        for _ in (1..<50) {

            let company = CompanyObject.ceateFakeComapnyList().shuffled().randomElement()!
            let tamMember = [TeamMember.generateTeamList().shuffled().randomElement()]

            let post = ActvityPost(
                company: company,
                poster: Bool.random() ? tamMember.randomElement()! : nil,
                caption: generateRandomStatus(),
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
                caption: generateRandomStatus(),
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

    static func generateRandomMeda() -> [ActvityPost.Media?] {

//        let videoTitle = "move-\(Int.random(in: 1...8))"

        let filteredPhotos = Array(
            Set(
                [
                    IdentifiableImage(image: CompanyObject.generateRadomImage()),
                    IdentifiableImage(image: CompanyObject.generateRadomImage()),
                    IdentifiableImage(image: CompanyObject.generateRadomImage())
                ]
            )
        )

        var array = [
            Bool.random() ? nil: ( Bool.random() ? nil : ActvityPost.Media.donationProgress(Double.random(in: 0...500), Bool.random() ? 800 : 1000)),
            Bool.random() ? nil: ActvityPost.Media.photoCarousel(filteredPhotos) ,
            Bool.random() ? nil:  ActvityPost.Media.photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
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

    static func generateRandomStatus() -> String {
        let text = [
            generateOne(),
            generateTwo(),
            generateThree()
        ].shuffled().randomElement()!
        let ending = ["!","...",".","?",""]
        let emojiEnding = [" #NGO", " 🌎", " 🚧", " 🚜", " 🌾", " 🏥"," 🏡"]

        let a = text

        return String(a.trimmingCharacters(in: .whitespaces) + (ending.shuffled().randomElement()!)) + (Bool.random() ? "" : emojiEnding.shuffled().first!)

    }

    static func generateBio() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
    }

    static func generateOne() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing"
    }


    static func generateTwo() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
    }

    static func generateThree() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"
    }

    static func generateFour() -> String {
        return "Lorem ipsum"
    }

    static func returnStructuredTweetList() -> [ActvityPost] {

        func returnCompany() -> CompanyObject {
           return CompanyObject.ceateFakeComapnyList().randomElement()!
        }

        // COme back

        return [
            ActvityPost(
                company: returnCompany(),
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 1
            ),
            ActvityPost(
                company: returnCompany(),
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
                hourAgoPosted: 1
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 2
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 2
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: ActvityPost.Media.photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
                hourAgoPosted: 3
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil ,//.video("move-1"),
                hourAgoPosted: 1
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 3
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 3
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 4
            ),

            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: .photoCarousel(
                    [
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                    ]
                ),
                hourAgoPosted: 4
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: "We're $200 away from our fundrasing goal! Thank you all for the support! ",
                media:.donationProgress(250, 500),
                hourAgoPosted: 4
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 5
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
                hourAgoPosted: 5
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 5
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media:  nil ,//.video("move-8"),
                hourAgoPosted: 5
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
                hourAgoPosted: 6
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 6
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil ,//.video("move-2"),
                hourAgoPosted: 7
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 7
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
                hourAgoPosted: 8
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 8
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 8
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: ActvityPost.Media.photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
                hourAgoPosted: 9
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil ,//.video("move-1"),
                hourAgoPosted: 9
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 9
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 9
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 10
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: .photoCarousel(
                    [
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                    ]
                ),
                hourAgoPosted: 10
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: "We're $200 away from our fundrasing goal! Thank you all for the support! ",
                media:.donationProgress(250, 500),
                hourAgoPosted: 10
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 11
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
                hourAgoPosted: 11
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 11
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil, //.video("move-6"),
                hourAgoPosted: 12
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage())),
                hourAgoPosted: 12
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: TeamMember.generateTeamList().randomElement()!,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil,
                hourAgoPosted: 13
            ),
            ActvityPost(
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                poster: nil,
                caption: TweetGenerator.generateRandomStatus(),
                media: nil ,// .video("move-1"),
                hourAgoPosted: 13
            )
        ]
    }
}
