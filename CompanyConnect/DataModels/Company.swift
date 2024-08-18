import Foundation
import MapKit
import SwiftUI

struct Coordinates: Codable {
    public var latitude: CLLocationDegrees
    public var longitude: CLLocationDegrees
}

extension Coordinates {
    func returnCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Company: Codable, Identifiable, Hashable {
    let id: String
    let orginizationName: String
    let coordinates: Coordinates
    let category: Category
    let coverImageUrl: String
    let missionStatement: String
    let bio: String
    var team: [TeamMember]
    let briefHistoryObject: BriefHistory
    var projects: [Project]
    let logoImageUrl: String

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    public static func == (lhs: Company, rhs: Company) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Company {
    static func createFakeCompanyObject() -> Company {
        Company(
            id: UUID().uuidString,
            orginizationName: "Company Inc",
            coordinates: Coordinates(
                latitude: CLLocationDegrees(Int.random(in: 0..<20)),
                longitude: CLLocationDegrees(Int.random(in: -100..<20))
            ),
            category: Category.allCases.randomElement() ?? .community,
            coverImageUrl: "imageUrl",
            missionStatement: "Mission Statement",
            bio: StringGenerator.generateShortString(),
            team: TeamMember.generateRandomTeamList(),
            briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
            projects: Project.generateFakeProjectList(),
            logoImageUrl: "imageUrl"
        )
    }

    static func createFakeComapnyList() -> [Company] {
        [
            Company(
                id: UUID().uuidString,
                orginizationName: "Cars for Kids",
                coordinates: Coordinates(
                    latitude: 18.542952, longitude: -72.39234
                ),
                category: .community,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "A.D.F.R.A",
                coordinates: Coordinates(
                    latitude: -22.859839, longitude: -43.267511
                ),
                category: .healthcare,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "Ever Green",
                coordinates: Coordinates(
                    latitude: 30.053881, longitude: 31.238474
                ),
                category: .environmental,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "EDU Global",
                coordinates: Coordinates(
                    latitude: 31.771959, longitude: 35.217018
                ),
                category: .education,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "True Vison",
                coordinates: Coordinates(
                    latitude: 41.9001, longitude: -71.0898
                ),
                category: .womensRights,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "S.A.O.M",
                coordinates: Coordinates(
                    latitude: 43.84864, longitude: 18.35644
                ),
                category: .veterans,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "People4All",
                coordinates: Coordinates(
                    latitude: 38.889931, longitude: -77.009003
                ),
                category: .humanRights,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "VENTRA",
                coordinates: Coordinates(
                    latitude: -33.918861, longitude: 18.4233
                ),
                category: .indigenousRights,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "Blue Aid",
                coordinates: Coordinates(
                    latitude: 11.562108, longitude: 104.888535
                ),
                category: .healthcare,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "Tree Vision",
                coordinates: Coordinates(
                    latitude: 6.4969, longitude: 2.6289
                ),
                category: .environmental,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "Mantra",
                coordinates: Coordinates(
                    latitude: -16.5, longitude: -68.15
                ),
                category: .community,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"

            ),
            Company(
                id: UUID().uuidString,
                orginizationName: "G.H.G",
                coordinates: Coordinates(
                    latitude: 17.1522786, longitude: -89.0800227
                ),
                category: .healthcare,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistory.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            )
        ].shuffled()
    }
}
