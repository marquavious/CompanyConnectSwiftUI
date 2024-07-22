//
//  TeamMember.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct TeamMember: Codable {
    let name: String
    let position: String
    let imageUrl: String
}

extension TeamMember {
    static func generateRandomTeamList() -> [TeamMember] {
         [
            TeamMember(
                name: "John Doe",
                position: "CEO",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                name: "Johnny A",
                position: "Social Media",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                name: "Shea",
                position: "Logistics",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                name: "Marq",
                position: "Finance",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                name: "Danna H",
                position: "Fundraising Officer",
                imageUrl: "imageUrl"
            ),
            TeamMember(
                name: "Janna Ho",
                position: "Coordinator",
                imageUrl: "imageUrl"
            )
        ].shuffled()
    }
}
