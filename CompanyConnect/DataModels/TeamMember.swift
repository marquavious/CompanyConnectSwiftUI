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
                id: "0001",
                name: "John Doe",
                position: "CEO",
                imageUrl: "imageUrl"
            )
    }

    static func generateRandomTeamList() -> [TeamMember] {
         [
            TeamMember(
                id: "0001",
                name: "John Doe",
                position: "CEO",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: "0002",
                name: "Johnny A",
                position: "Social Media",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: "0003",
                name: "Shea",
                position: "Logistics",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: "0004",
                name: "Marq",
                position: "Finance",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: "0005",
                name: "Danna H",
                position: "Fundraising Officer",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                id: "0006",
                name: "Janna Ho",
                position: "Coordinator",
                imageUrl: "imageUrl"
            )
        ].shuffled()
    }
}
