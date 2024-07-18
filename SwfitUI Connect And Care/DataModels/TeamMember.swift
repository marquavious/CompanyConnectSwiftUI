//
//  TeamMember.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct TeamMember: Hashable, Identifiable {

    let id = UUID()
    let name: String
    let position: String
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension TeamMember {
    static func generateRandomTeamList() -> [TeamMember] {
         [
            TeamMember(
                name: "John Doe",
                position: "CEO",
                image: Image("face-1")
            ),
            TeamMember(
                name: "Johnny A",
                position: "Social Media",
                image:  Image("face-2")
            ),
            TeamMember(
                name: "Shea",
                position: "Logistics",
                image:  Image("face-3")
            ),
            TeamMember(
                name: "Marq",
                position: "Finance",
                image: Image("face-4")
            ),
            TeamMember(
                name: "Danna H",
                position: "Fundraising Officer",
                image:  Image("face-5")
            ),
            TeamMember(
                name: "Janna Ho",
                position: "Coordinator",
                image:  Image("face-6")
            )
        ].shuffled()
    }
}
