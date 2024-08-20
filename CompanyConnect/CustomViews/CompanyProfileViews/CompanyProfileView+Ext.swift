//
//  CompanyProfileView+Ext.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation
import SwiftUI

extension CompanyProfileView {

    enum LoadingState: Equatable {
        case loading
        case fetched(Company)
        case error(Error)

        static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading), (.fetched, .fetched):
                true
            case let (.error(lhsError), .error(rhsError)):
                lhsError.localizedDescription == rhsError.localizedDescription
            default:
                false
            }
        }
    }

    enum ProfileTabs: Int, CaseIterable {
        case about, recentActivity

        var titleString: String {
            switch self {
            case .about:
                "ABOUT"
            case .recentActivity:
                "RECENT ACTIVITY"
            }
        }
    }

    enum AboutSection: Int, CaseIterable, Identifiable {

        case missionStatement
        case ourTeam
        case briefHistory
        case locations
        case projects

        var id: String {
            return title
        }

        var title: String {
            switch self {
            case .missionStatement:
                "Mission Statement"
            case .ourTeam:
                "Our Team"
            case .briefHistory:
                "Brief History"
            case .locations:
                "Location"
            case .projects:
                "Projects"
            }
        }

        var mediaPlacement: MediaLocation {
            switch self {
            case .missionStatement:
                    .bottom
            case .ourTeam:
                    .bottom
            case .briefHistory:
                    .bottom
            case .locations:
                    .middle
            case .projects:
                    .middle
            }
        }

        func descriptionText(company: Company) -> String? {
            switch self {
            case .missionStatement:
                company.missionStatement
            case .ourTeam:
                nil
            case .briefHistory:
                company.briefHistoryObject.history
            case .locations:
                company.missionStatement
            case .projects:
                nil
            }
        }

        @ViewBuilder
        func mediaView(company: Company) -> some View {
            switch self {
            case .missionStatement:
                // For some reason EmptyView() Buggs out the insets
                // So we go with this instead
                Divider().frame(height: .zero).opacity(.zero)
            case .ourTeam:
                OurTeamPhotoScrollerView(teamMembers: company.team)
            case .briefHistory:
                BriefHistoryPhotoScrollerView(briefHistoryObject: company.briefHistoryObject)
            case .locations:
                CompanyProfileMapView(
                    coordinate: company.coordinates,
                    annotaionUrl: company.logoImageUrl,
                    annotaionName: company.orginizationName
                )
            case .projects:
                ProjectsScrollerView(projects: company.projects)
            }
        }
    }
}

#Preview {
    CompanyProfileView(companyObject: Company.createFakeCompanyObject())
}
