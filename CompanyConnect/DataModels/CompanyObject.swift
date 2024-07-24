import Foundation
import MapKit
import SwiftUI

struct Coordinate: Codable {
    public var latitude: CLLocationDegrees
    public var longitude: CLLocationDegrees
}

extension Coordinate {
    func returnCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct CompanyObject: Codable, Identifiable, Hashable {
    let id: String
    let orginizationName: String
    let coordinate: Coordinate
    let category: Category
    let coverImageUrl: String
    let missionStatement: String
    let bio: String
    var team: [TeamMember]
    let briefHistoryObject: BriefHistoryObject
    var projects: [Project]
    let logoImageUrl: String

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    public static func == (lhs: CompanyObject, rhs: CompanyObject) -> Bool {
        return lhs.id == rhs.id
    }
}

extension CompanyObject {
    static func createFakeCompanyObject() -> CompanyObject {
        CompanyObject(
            id: "1",
            orginizationName: "Company Inc",
            coordinate: Coordinate(
                latitude: CLLocationDegrees(Int.random(in: 0..<20)),
                longitude: CLLocationDegrees(Int.random(in: -100..<20))
            ),
            category: Category.allCases.randomElement() ?? .community,
            coverImageUrl: "imageUrl",
            missionStatement: "Mission Statement",
            bio: StringGenerator.generateShortString(),
            team: TeamMember.generateRandomTeamList(),
            briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
            projects: Project.generateFakeProjectList(),
            logoImageUrl: "imageUrl"
        )
    }

    static func createFakeComapnyList() -> [CompanyObject] {
        [
            CompanyObject(
                id: "2",
                orginizationName: "Cars for Kids",
                coordinate: Coordinate(
                    latitude: 18.542952, longitude: -72.39234
                ),
                category: .community,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "3",
                orginizationName: "A.D.F.R.A",
                coordinate: Coordinate(
                    latitude: -22.859839, longitude: -43.267511
                ),
                category: .healthcare,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "4",
                orginizationName: "Ever Green",
                coordinate: Coordinate(
                    latitude: 30.053881, longitude: 31.238474
                ),
                category: .environmental,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "5",
                orginizationName: "EDU Global",
                coordinate: Coordinate(
                    latitude: 31.771959, longitude: 35.217018
                ),
                category: .education,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "6",
                orginizationName: "True Vison",
                coordinate: Coordinate(
                    latitude: 41.9001, longitude: -71.0898
                ),
                category: .womensRights,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "7",
                orginizationName: "S.A.O.M",
                coordinate: Coordinate(
                    latitude: 43.84864, longitude: 18.35644
                ),
                category: .veterans,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "8",
                orginizationName: "People4All",
                coordinate: Coordinate(
                    latitude: 38.889931, longitude: -77.009003
                ),
                category: .humanRights,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "9",
                orginizationName: "VENTRA",
                coordinate: Coordinate(
                    latitude: -33.918861, longitude: 18.4233
                ),
                category: .indigenousRights,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "10",
                orginizationName: "Blue Aid",
                coordinate: Coordinate(
                    latitude: 11.562108, longitude: 104.888535
                ),
                category: .healthcare,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "11",
                orginizationName: "Tree Vision",
                coordinate: Coordinate(
                    latitude: 6.4969, longitude: 2.6289
                ),
                category: .environmental,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            ),
            CompanyObject(
                id: "12",
                orginizationName: "Mantra",
                coordinate: Coordinate(
                    latitude: -16.5, longitude: -68.15
                ),
                category: .community,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"

            ),
            CompanyObject(
                id: "13",
                orginizationName: "G.H.G",
                coordinate: Coordinate(
                    latitude: 17.1522786, longitude: -89.0800227
                ),
                category: .healthcare,
                coverImageUrl: "imageUrl",
                missionStatement: StringGenerator.generateShortString(),
                bio: StringGenerator.generateShortString(),
                team: TeamMember.generateRandomTeamList(),
                briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject(),
                projects: Project.generateFakeProjectList(),
                logoImageUrl: "imageUrl"
            )
        ].shuffled()
    }
}
