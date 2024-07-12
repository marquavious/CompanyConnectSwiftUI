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

    static func generateTeamList() -> [TeamMember] {
        var array =  [
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

    static func generateBio() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
}
