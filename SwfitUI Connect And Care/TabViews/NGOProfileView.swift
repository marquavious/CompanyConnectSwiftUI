//
//  NGOProfileView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/30/23.
//

import SwiftUI
import MapKit

struct NGOProfileView: View {

    struct Constants {
        static let sectionPadding: CGFloat = 15
    }

    enum ProfileTabs: Int, CaseIterable {
        case about, activity
    }

    enum AboutSections: Int, CaseIterable, Identifiable {
        case missionStatements, ourTeam, briefHistory, locations, projects

        var id: String {
            return sectionTitles
        }

        var sectionTitles: String {
            switch self {
            case .missionStatements:
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

        var sectionMediaLocation: MediaLocation {
            switch self {
            case .missionStatements:
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

        func sectionDescriptionText(companyObject: CompanyObject) -> String? {
            switch self {
            case .missionStatements:
                companyObject.briefHistoryObject.history
            case .ourTeam:
                nil
            case .briefHistory:
                companyObject.briefHistoryObject.history
            case .locations:
                companyObject.missionStatement
            case .projects:
                nil
            }
        }

        @ViewBuilder
        func sectionView(companyObject: CompanyObject) -> some View {
            switch self {
            case .missionStatements:
                EmptyView()
            case .ourTeam:
                OurTeamPhotoScrollerView(companyObject: companyObject)
            case .briefHistory:
                BriefHistoryPhotoScrollerView(companyObject: companyObject)
            case .locations:
                CompanyProfileMapView(company: companyObject)
            case .projects:
                ProjectsScrollerView(companyObject: companyObject)
            }
        }
    }

    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State var showActivityFeed: Bool = true
    @State private var currentTab: ProfileTabs = .about
    private var viewModel: ActivityFeedViewViewModelType
    private let company: CompanyObject

    init(companyObject: CompanyObject) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
        self.company = companyObject
        self.viewModel = CompanyActivityFeed(company: companyObject)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: Constants.sectionPadding) {
                CompanyProfileHeaderView(
                    companyObject: company,
                    currentTab: $currentTab
                )

                switch currentTab {
                case .about:
                    ForEach(AboutSections.allCases) { section in
                        NGOProfileTextView(
                            titleText: section.sectionTitles,
                            text: section.sectionDescriptionText(companyObject: company),
                            mediaLocation: section.sectionMediaLocation
                        ) {
                            section.sectionView(companyObject: company)
                        }
                    }
                case .activity:
                    ActivityFeedScrollView(
                        shouldShowCategoryFilter: false,
                        viewModel: viewModel
                    )
                }
            }
        }
    }

}

#Preview {
    NGOProfileView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
