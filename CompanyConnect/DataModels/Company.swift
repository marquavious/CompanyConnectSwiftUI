import Foundation
import MapKit
import SwiftUI
import SwiftData
import FirebaseFirestore

struct Coordinates: Codable {
    public var latitude: CLLocationDegrees
    public var longitude: CLLocationDegrees
}

extension Coordinates {
    func returnCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

//@Model
class Company: Codable, Identifiable, Hashable {

    enum CodingKeys: String, CodingKey {
        case id
        case orginizationName = "orginization_name"
        case coordinates
        case category
        case coverImageUrl = "cover_image_url"
        case missionStatement = "mission_statement"
        case bio
        case team
        case briefHistoryObject = "brief_history_object"
        case projects
        case logoImageUrl = "logo_image_url"
    }

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

    // All INITS BELOW ARE BECUASE OF SWIFT DATA AND @MODEL
    init(
        id: String,
         orginizationName: String,
         coordinates: Coordinates,
         category: Category,
         coverImageUrl: String,
         missionStatement: String,
         bio: String,
         team: [TeamMember],
         briefHistoryObject: BriefHistory,
         projects: [Project],
         logoImageUrl: String
    ) {
        self.id = id
        self.orginizationName = orginizationName
        self.coordinates = coordinates
        self.category = category
        self.coverImageUrl = coverImageUrl
        self.missionStatement = missionStatement
        self.bio = bio
        self.team = team
        self.briefHistoryObject = briefHistoryObject
        self.projects = projects
        self.logoImageUrl = logoImageUrl
    }

    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        orginizationName = try container.decode(String.self, forKey: .orginizationName)
        coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        category = try container.decode(Category.self, forKey: .category)
        coverImageUrl = try container.decode(String.self, forKey: .coverImageUrl)
        missionStatement = try container.decode(String.self, forKey: .missionStatement)
        bio = try container.decode(String.self, forKey: .bio)
        team = try container.decode([TeamMember].self, forKey: .team)
        briefHistoryObject = try container.decode(BriefHistory.self, forKey: .briefHistoryObject)
        projects = try container.decode([Project].self, forKey: .projects)
        logoImageUrl = try container.decode(String.self, forKey: .logoImageUrl)
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(orginizationName, forKey: .orginizationName)
        try container.encode(coordinates, forKey: .coordinates)
        try container.encode(category, forKey: .category)
        try container.encode(coverImageUrl, forKey: .coverImageUrl)
        try container.encode(missionStatement, forKey: .missionStatement)
        try container.encode(bio, forKey: .bio)
        try container.encode(team, forKey: .team)
        try container.encode(briefHistoryObject, forKey: .briefHistoryObject)
        try container.encode(projects, forKey: .projects)
        try container.encode(logoImageUrl, forKey: .logoImageUrl)
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
