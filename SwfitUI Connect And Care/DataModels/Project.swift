//
//  Project.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

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

        var statusColor: Color {
            switch self {
            case .completed:
                return Color(red: 28/255, green: 68/255, blue: 108/255)
            case .inProgress:
                return .orange
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
}

extension Project {
    static func generateFakeProjectList() -> [Project] {
        return [
            Project(
                name: "Project 1",
                description: StringGenerator.generateLongString(),
                status: .completed,
                image: Image.generateRadomImage()
            ),
            Project(
                name: "Project 2",
                description: StringGenerator.generateLongString(),
                status: .inProgress,
                image:  Image.generateRadomImage()
            ),
            Project(
                name: "Project 3",
                description: StringGenerator.generateLongString(),
                status: .watingToBeFunded,
                image: Image.generateRadomImage()
            ),
            Project(
                name: "Project 4",
                description: StringGenerator.generateLongString(),
                status: .completed,
                image: Image.generateRadomImage()
            ),
            Project(
                name: "Project 5",
                description: StringGenerator.generateLongString(),
                status: .watingToBeFunded,
                image: Image.generateRadomImage()
            )
        ]
    }
}
