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
