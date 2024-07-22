//
//  Project.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct Project: Codable, Hashable, Identifiable {

    enum Status: String, Codable {
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

    let id: String
    let name: String
    let description: String
    let status: Status
    let imageUrl: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Project {
    static func generateFakeProjectList() -> [Project] {
        return [
            Project(
                id: UUID().uuidString,
                name: "Project 1",
                description: StringGenerator.generateLongString(),
                status: .completed,
                imageUrl: "imageUrl"
            ),
            Project(
                id: UUID().uuidString,
                name: "Project 2",
                description: StringGenerator.generateLongString(),
                status: .inProgress,
                imageUrl: "imageUrl"
            ),
            Project(
                id: UUID().uuidString,
                name: "Project 3",
                description: StringGenerator.generateLongString(),
                status: .watingToBeFunded,
                imageUrl: "imageUrl"
            ),
            Project(
                id: UUID().uuidString,
                name: "Project 4",
                description: StringGenerator.generateLongString(),
                status: .completed,
                imageUrl: "imageUrl"
            ),
            Project(
                id: UUID().uuidString, 
                name: "Project 5",
                description: StringGenerator.generateLongString(),
                status: .watingToBeFunded,
                imageUrl: "imageUrl"
            )
        ]
    }
}
