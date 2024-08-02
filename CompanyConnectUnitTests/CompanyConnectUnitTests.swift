//
//  CompanyConnectUnitTests.swift
//  CompanyConnectUnitTests
//
//  Created by Marquavious Draggon on 7/30/24.
//

import XCTest
@testable import CompanyConnect

final class CompanyConnectUnitTests: XCTestCase {

    func testCompanyObjectTests() throws {
        let companyObject = CompanyObject(
            id: "id",
            orginizationName: "Name",
            coordinate: Coordinates(
                latitude: 0,
                longitude: 0
            ),
            category: .community,
            coverImageUrl: "img_url",
            missionStatement: "Mission Statment",
            bio: "Bio",
            team: [
                TeamMember(id: "id", name: "Name", position: "Position", imageUrl: "img_url"),
                TeamMember(id: "id2", name: "Name", position: "Position", imageUrl: "img_url"),
                TeamMember(id: "id3", name: "Name", position: "Position", imageUrl: "img_url")
            ],
            briefHistoryObject: BriefHistoryObject(
                history: "History",
                imageObjects: [
                    BriefHistoryImageObject(caption: "Caption", imageUrl: "img_url")
                ]
            ),
            projects: [
                Project(id: "id1", name: "Name", description: "Description", status: .completed, imageUrl: "img_url"),
                Project(id: "id2", name: "Name", description: "Description", status: .inProgress, imageUrl: "img_url"),
                Project(id: "id3", name: "Name", description: "Description", status: .planning, imageUrl: "img_url"),
            ],
            logoImageUrl: "img_url"
        )

        XCTAssertEqual(companyObject.team.count, 3)
        XCTAssertEqual(companyObject.projects.count, 3)
        XCTAssertEqual(companyObject.briefHistoryObject.imageObjects.count, 1)

    }
}
