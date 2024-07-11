//
//  Project.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct Project: Hashable, Identifiable {

    enum Status {
        case completed, inProgress, watingToBeFunded

        var displayName: String {
            switch self {

            case .completed:
                return "COMPLETED"
            case .inProgress:
                return "IN PROGRESS"
            case .watingToBeFunded:
                return "FUNDRAISING"
            }
        }

        var displayColor: Color {
            switch self {
            case .completed:
                return Color(red: 28/255, green: 68/255, blue: 108/255)
            case .inProgress:
                return Color.orange
            case .watingToBeFunded:
                return .red
            }
        }
    }

    let id = UUID()
    let name: String
    let description: String
    let status: Status
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func generateProjectList() -> [Project] {
        return [
            Project(
                name: "Project 1",
                description: generateBio(),
                status: .completed,
                image: CompanyObject.generateRadomImage()
            ),
            Project(
                name: "Project 2",
                description: generateBio(),
                status: .inProgress,
                image:  CompanyObject.generateRadomImage()
            ),
            Project(
                name: "Project 3",
                description: generateBio(),
                status: .watingToBeFunded,
                image: CompanyObject.generateRadomImage()
            ),
            Project(
                name: "Project 4",
                description: generateBio(),
                status: .completed,
                image: CompanyObject.generateRadomImage()
            ),
            Project(
                name: "Project 5",
                description: generateBio(),
                status: .watingToBeFunded,
                image: CompanyObject.generateRadomImage()
            ),
        ]
    }

    static func generateBio() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
}
