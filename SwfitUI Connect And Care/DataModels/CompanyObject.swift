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
    let logoImageData: LogoImageViewData

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

    static func createFakeComapnyList() -> [CompanyObject] {
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "C.4.K",
                    addAbbreviationToLogo: false,
                    systemLogo: Image(systemName: "car.circle.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: .orange
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "A.D.F",
                    addAbbreviationToLogo: true,
                    systemLogo: Image(systemName: "cross.case.circle.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: Color.random()
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "E.V.G",
                    addAbbreviationToLogo: false,
                    systemLogo: Image(systemName: "tree.circle.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: Color.random()
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "E.D.U",
                    addAbbreviationToLogo: true,
                    systemLogo: Image(systemName: "globe.europe.africa.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: .green
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "T.V.",
                    addAbbreviationToLogo: false,
                    systemLogo: Image(systemName: "eye.circle.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: Color.random()
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "S.A.O.",
                    addAbbreviationToLogo: false,
                    systemLogo: Image(systemName: "figure.walk.circle.fill"),
                    logoBackground: nil,
                    themeColor: Color(red: 28/255, green: 68/255, blue: 108/255)
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "P.4.A",
                    addAbbreviationToLogo: false,
                    systemLogo: Image(systemName: "peacesign"),
                    logoBackground: nil,
                    themeColor: .purple
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "V.E.N",
                    addAbbreviationToLogo: true,
                    systemLogo: Image(systemName: "circle.hexagongrid.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: .brown
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "B.A.",
                    addAbbreviationToLogo: true,
                    systemLogo: Image(systemName: "rotate.3d.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: .blue
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "T.V.",
                    addAbbreviationToLogo: true,
                    systemLogo: Image(systemName: "bird.circle.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: .cyan
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "M",
                    addAbbreviationToLogo: false,
                    systemLogo: Image(systemName: "arrow.up.left.arrow.down.right.circle.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: .gray
                )
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
                logoImageData: LogoImageViewData(
                    companyAbbreviation: "G.H.G",
                    addAbbreviationToLogo: false,
                    systemLogo: Image(systemName: "sun.and.horizon.circle.fill"),
                    logoBackground: generateRadomImage(),
                    themeColor: Color.random()
                )
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
