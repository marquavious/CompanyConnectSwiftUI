//
//  TeamMember.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct TeamMember: Codable {
    let id: String
    let name: String
    let position: String
    let imageUrl: String
}

extension TeamMember {
    static func generateRandomTeamMember() -> TeamMember {
        TeamMember(
            id: UUID().uuidString,
            name: "John Doe",
            position: "CEO",
            imageUrl: "imageUrl"
        )
    }

    static func generateRandomTeamList() -> [TeamMember] {
        [
            TeamMember(
                id: UUID().uuidString,
                name: "John Doe",
                position: "CEO",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: UUID().uuidString,
                name: "Johnny A",
                position: "Social Media",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: UUID().uuidString,
                name: "Shea",
                position: "Logistics",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: UUID().uuidString,
                name: "Marq",
                position: "Finance",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: UUID().uuidString,
                name: "Danna H",
                position: "Fundraising Officer",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: UUID().uuidString,
                name: "Janna Ho",
                position: "Coordinator",
                imageUrl: "imageUrl"
            )
        ].shuffled()
    }
}
