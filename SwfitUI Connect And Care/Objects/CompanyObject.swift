import Foundation
import MapKit
import SwiftUI

struct CompanyObject: Identifiable, Hashable {
    let id = UUID()
    let logo: Image = generateRadomImage()
    let orginizationName: String
    let coordinate: CLLocationCoordinate2D
    let category: Category
    let coverImage: Image
    let missionStatement: String
//    let missionStatement: String
    let team: [TeamMember]
    let briefHistoryObject = generateBriefHistoryObject()
    let projects = ["Projects", "Projects", "Projects"]

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
                    caption: "Log House",
                    image: generateRadomImage()
                ),
                BriefHistoryImageObject(
                    caption: "Log House 2",
                    image: generateRadomImage()
                ),
                BriefHistoryImageObject(
                    caption: "Log House 3",
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
        return [
            CompanyObject(
                orginizationName: "Cars for Kids 1",
                coordinate: CLLocationCoordinate2D(
                    latitude: 18.542952, longitude: -72.39234
                ), 
                category: .community, coverImage: generateRadomImage(),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList()
            ),
            CompanyObject(
                orginizationName: "Cars for Kids 2",
                coordinate: CLLocationCoordinate2D(
                    latitude: -22.859839, longitude: -43.267511
                ),
                category: .womensRights, coverImage: generateRadomImage(),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList()
            ),
            CompanyObject(
                orginizationName: "Cars for Kids 3",
                coordinate: CLLocationCoordinate2D(
                    latitude: 30.053881, longitude: 31.238474
                ),
                category: .veterans, coverImage: generateRadomImage(),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList()
            ),
            CompanyObject(
                orginizationName: "Cars for Kids 4",
                coordinate: CLLocationCoordinate2D(
                    latitude: 31.771959, longitude: 35.217018
                ),
                category: .healthcare, coverImage: generateRadomImage(),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList()
            ),
            CompanyObject(
                orginizationName: "Cars for Kids 5",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.9001, longitude: -71.0898
                ),
                category: .healthcare, coverImage: generateRadomImage(),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList()
            ),
            CompanyObject(
                orginizationName: "Cars for Kids 6",
                coordinate: CLLocationCoordinate2D(
                    latitude: 43.84864, longitude: 18.35644
                ),
                category: .conflictReleief, coverImage: generateRadomImage(),
                missionStatement: generateSummary(),
                team: TeamMember.generateTeamList()
            )
        ]
    }
}

struct TeamMember: Hashable, Identifiable {

    let id = UUID()
    let name: String
    let bio: String
    let position: String
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func generateTeamList() -> [TeamMember] {
        return [
            TeamMember(
                name: "John Doe",
                bio: generateBio(),
                position: "CEO",
                image: CompanyObject.generateRadomImage()
            ),
            TeamMember(
                name: "John Doe",
                bio: generateBio(),
                position: "CEO",
                image:  CompanyObject.generateRadomImage()
            ),
            TeamMember(
                name: "John Doe",
                bio: generateBio(),
                position: "CEO",
                image: CompanyObject.generateRadomImage()
            ),
            TeamMember(
                name: "John Doe",
                bio: generateBio(),
                position: "CEO",
                image: CompanyObject.generateRadomImage()
            ),
            TeamMember(
                name: "John Doe",
                bio: generateBio(),
                position: "CEO",
                image:  CompanyObject.generateRadomImage()
            ),
        ]
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

