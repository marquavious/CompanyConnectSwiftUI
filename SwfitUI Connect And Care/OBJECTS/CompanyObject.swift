import Foundation
import MapKit
import SwiftUI

struct User: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let donations: [Donation]
    let scheduledDonations: [Donation]
}

struct CompanyObject: Identifiable, Hashable {
    let id = UUID()
    let logo: Image = generateRadomImage()
    let orginizationName: String
    let coordinate: CLLocationCoordinate2D
    let category: Category
    let coverImage: Image
    let missionStatement: String
    let team: [TeamMember]
    let briefHistoryObject = generateBriefHistoryObject()
    let projects: [Project] = Project.generateProjectList()
    let logoSystemName: String
    let radomShowShorthandName: Bool
    let shouldUseSolidColorBackground: Bool
    let themeColor: Color

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    public static func == (lhs: CompanyObject, rhs: CompanyObject) -> Bool {
        return lhs.id == rhs.id
    }

    static func generateRadomImage() -> Image {

        let imagesArray = [
            Image("charleyrivers"),
            Image("chilkoottrail"),
            Image("chincoteague"),
            Image("hiddenlake"),
            Image("icybay"),
            Image("lakemcdonald"),
            Image("rainbowlake"),
            Image("silversalmoncreek"),
            Image("stmarylake"),
            Image("turtlerock"),
            Image("twinlake"),
            Image("umbagog")
        ]

        return imagesArray.randomElement() ?? Image("twinlake")
    }

    static func generateBriefHistoryObject() -> BriefHistoryObject {
        return BriefHistoryObject(
            history: generateSummary(),
            imageObjects: [
                BriefHistoryImageObject(
                    caption: "Where it all began",
                    image: generateRadomImage()
                ),
                BriefHistoryImageObject(
                    caption: "Breaking ground!",
                    image: generateRadomImage()
                ),
                BriefHistoryImageObject(
                    caption: "25 Years later...",
                    image: generateRadomImage()
                ),
            ]
        )
    }

    static func generateSummary() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }

    static func generateShort() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }

    static func ceateFakeComapnyList() -> [CompanyObject] {
        var array = [
            CompanyObject(
                orginizationName: "Cars for Kids",
                coordinate: CLLocationCoordinate2D(
                    latitude: 18.542952, longitude: -72.39234
                ), 
                category: .community, 
                coverImage: Image("charleyrivers"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "car.circle.fill",
                radomShowShorthandName:false,
                shouldUseSolidColorBackground: true, 
                themeColor: .orange
            ),
            CompanyObject(
                orginizationName: "A.D.F.R.A",
                coordinate: CLLocationCoordinate2D(
                    latitude: -22.859839, longitude: -43.267511
                ),
                category: .healthcare, 
                coverImage: Image("chilkoottrail"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "cross.case.circle.fill",
                radomShowShorthandName: true,
                shouldUseSolidColorBackground: false,
                themeColor: Color.random()
            ),
            CompanyObject(
                orginizationName: "Ever Green",
                coordinate: CLLocationCoordinate2D(
                    latitude: 30.053881, longitude: 31.238474
                ),
                category: .environmental,
                coverImage: Image("chincoteague"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "tree.circle.fill",
                radomShowShorthandName: false,
                shouldUseSolidColorBackground: false,
                themeColor: Color.random()
            ),
            CompanyObject(
                orginizationName: "EDU Global",
                coordinate: CLLocationCoordinate2D(
                    latitude: 31.771959, longitude: 35.217018
                ),
                category: .education,
                coverImage: Image("hiddenlake"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "globe.europe.africa.fill",
                radomShowShorthandName: true,
                shouldUseSolidColorBackground: true,
                themeColor: .green
            ),
            CompanyObject(
                orginizationName: "True Vison",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.9001, longitude: -71.0898
                ),
                category: .womensRights,
                coverImage: Image("icybay"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "eye.circle.fill",
                radomShowShorthandName: false,
                shouldUseSolidColorBackground: false,
                themeColor: Color.random()
            ),
            CompanyObject(
                orginizationName: "S.A.O.M",
                coordinate: CLLocationCoordinate2D(
                    latitude: 43.84864, longitude: 18.35644
                ),
                category: .veterans, 
                coverImage: Image("lakemcdonald"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "figure.walk.circle.fill",
                radomShowShorthandName: false,
                shouldUseSolidColorBackground:true,
                themeColor: Color(red: 28/255, green: 68/255, blue: 108/255)
            ),
            CompanyObject(
                orginizationName: "People4All",
                coordinate: CLLocationCoordinate2D(
                    latitude: 38.889931, longitude: -77.009003
                ),
                category: .humanRights,
                coverImage: Image("rainbowlake"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "peacesign",
                radomShowShorthandName: false,
                shouldUseSolidColorBackground:true,
                themeColor: .purple
                // peacesign
            ),
            CompanyObject(
                orginizationName: "VENTRA",
                coordinate: CLLocationCoordinate2D(
                    latitude: -33.918861, longitude: 18.4233
                ),
                category: .indigenousRights,
                coverImage: Image("silversalmoncreek"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "circle.hexagongrid.fill",
                radomShowShorthandName: true,
                shouldUseSolidColorBackground: true,
                themeColor: .brown
            ),


            CompanyObject(
                orginizationName: "Blue Aid",
                coordinate: CLLocationCoordinate2D(
                    latitude: 11.562108, longitude: 104.888535
                ),
                category: .healthcare,
                coverImage: Image("stmarylake"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(),
                logoSystemName: "rotate.3d.fill",
                radomShowShorthandName: true,
                shouldUseSolidColorBackground: true,
                themeColor: .blue
            ),
            CompanyObject(
                orginizationName: "Tree Vision",
                coordinate: CLLocationCoordinate2D(
                    latitude: 6.4969, longitude: 2.6289
                ),
                category: .environmental,
                coverImage: Image("turtlerock"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "bird.circle.fill",
                radomShowShorthandName: true,
                shouldUseSolidColorBackground: true,
                themeColor: .cyan
            ),
            CompanyObject(
                orginizationName: "Mantra",
                coordinate: CLLocationCoordinate2D(
                    latitude: -16.5, longitude: -68.15
                ),
                category: .community,
                coverImage: Image("twinlake"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "arrow.up.left.arrow.down.right.circle.fill",
                radomShowShorthandName: false,
                shouldUseSolidColorBackground:true,
                themeColor: .gray
            ),
            CompanyObject(
                orginizationName: "G.H.G",
                coordinate: CLLocationCoordinate2D(
                    latitude: 17.1522786, longitude: -89.0800227
                ),
                category: .healthcare,
                coverImage: Image("umbagog"),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList(), 
                logoSystemName: "sun.and.horizon.circle.fill",
                radomShowShorthandName: true,
                shouldUseSolidColorBackground: false,
                themeColor: Color.random()
            )
        ]

        for i in 0...array.count {
            if i < 1, i > array.count {
                let post = array[i]
                let previousPost = array[i - 1]

                    if post.id == previousPost.id {
                        array.remove(at: i)
                    }
                }
            }

        return array
    }
}

struct TeamMember: Hashable, Identifiable {

    let id = UUID()
    let name: String
    let position: String
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func generateTeamList() -> [TeamMember] {
        var array =  [
            TeamMember(
                name: "John Doe",
                position: "CEO",
                image: Image("face-1")
            ),
            TeamMember(
                name: "Johnny A",
                position: "Social Media",
                image:  Image("face-2")
            ),
            TeamMember(
                name: "Shea",
                position: "Logistics",
                image:  Image("face-3")
            ),
            TeamMember(
                name: "Marq",
                position: "Finance",
                image: Image("face-4")
            ),
            TeamMember(
                name: "Danna H",
                position: "Fundraising Officer",
                image:  Image("face-5")
            ),
            TeamMember(
                name: "Janna Ho",
                position: "Coordinator",
                image:  Image("face-6")
            )
        ].shuffled()


        for i in 0...array.count {
            if i < 1, i > array.count {
                let post = array[i]
                let previousPost = array[i - 1]

                    if post.id == previousPost.id {
                        array.remove(at: i)
                    }
                }
            }

        return array
    }

    static func generateBio() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
}


struct BriefHistoryObject: Hashable, Identifiable {

    let id = UUID()

    let history: String
    let imageObjects: [BriefHistoryImageObject]

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct BriefHistoryImageObject: Hashable, Identifiable {

    let id = UUID()

    let caption: String
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct Donation: Hashable, Identifiable {

    enum PaymentMethod {
        case creditCard, paypal, applePay

        var displayName: String {
            switch self {
            case .creditCard:
                return "Credit Card"
            case .paypal:
                return "PayPal"
            case .applePay:
                return "Apple Pay"
            }
        }
    }

    let id = UUID()
    let amountInCents: Double
    let company: CompanyObject
    let date: Date
    let paymentMethod: PaymentMethod

    func displayAmount() -> String {
        return "$\(String(format: "%.0f", amountInCents))"
    }

    static func generateDonations() -> [Donation] {
        return [
            Donation(
                amountInCents: 100,
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                paymentMethod: .applePay),
            Donation(
                amountInCents: 200,
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                paymentMethod: .creditCard),
            Donation(
                amountInCents: 205,
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                paymentMethod: .paypal),
            Donation(
                amountInCents: 100,
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                paymentMethod: .applePay),
            Donation(
                amountInCents: 200,
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                paymentMethod: .creditCard
            ),
            Donation(
                amountInCents: 205,
                company: CompanyObject.ceateFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                paymentMethod: .paypal
            )
        ].sorted { donationOne, donationTwo in
            donationOne.date < donationTwo.date
        }
    }
}


struct Project: Hashable, Identifiable {

    enum Status {
        case completed, inProgress, watingToBeFunded

        var displayName: String {
            switch self {

            case .completed:
                return "COMPLETED"
            case .inProgress:
                return "IN PROGRESS"
            case .watingToBeFunded:
                return "FUNDRAISING"
            }
        }

        var displayColor: Color {
            switch self {
            case .completed:
                return Color(red: 28/255, green: 68/255, blue: 108/255)
            case .inProgress:
                return Color.orange
            case .watingToBeFunded:
                return .red
            }
        }
    }

    let id = UUID()
    let name: String
    let description: String
    let status: Status
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func generateProjectList() -> [Project] {
        return [
            Project(
                name: "Project 1",
                description: generateBio(),
                status: .completed,
                image: CompanyObject.generateRadomImage()
            ),
            Project(
                name: "Project 2",
                description: generateBio(),
                status: .inProgress,
                image:  CompanyObject.generateRadomImage()
            ),
            Project(
                name: "Project 3",
                description: generateBio(),
                status: .watingToBeFunded,
                image: CompanyObject.generateRadomImage()
            ),
            Project(
                name: "Project 4",
                description: generateBio(),
                status: .completed,
                image: CompanyObject.generateRadomImage()
            ),
            Project(
                name: "Project 5",
                description: generateBio(),
                status: .watingToBeFunded,
                image: CompanyObject.generateRadomImage()
            ),
        ]
    }

    static func generateBio() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
}

struct ActvityPost: Hashable, Identifiable {
    static func == (lhs: ActvityPost, rhs: ActvityPost) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    enum Media {
        case photo(IdentifiableImage)
        case photos([IdentifiableImage])
        case donationProgress(Double, Double)
        case video(String)

        var type: String {
            switch self {

            case .photo(_):
                return "photo"
            case .photos(_):
                return "photos"
            case .donationProgress(_, _):
                return "donationProgress"
            case .video(_):
                return "video"
            }
        }
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

struct IdentifiableImage: Identifiable, Hashable {
    let id = UUID()
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct IdentifiableVideo: Identifiable {
    let id = UUID()
    let videoID: String
}


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

        let videoTitle = "move-\(Int.random(in: 1...8))"

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
            Bool.random() ? nil: ActvityPost.Media.video(videoTitle),
            Bool.random() ? nil: ( Bool.random() ? nil : ActvityPost.Media.donationProgress(Double.random(in: 0...500), Bool.random() ? 800 : 1000)),
            Bool.random() ? nil: ActvityPost.Media.photos(filteredPhotos) ,
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
                media: .photos(
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
                media: .photos(
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
