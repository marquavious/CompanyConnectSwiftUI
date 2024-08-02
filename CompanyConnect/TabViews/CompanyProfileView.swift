//
//  CompanyProfileView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 11/30/23.
//

import SwiftUI
import MapKit

protocol CompanyProfileViewServiceType: HTTPDataDownloader {
    func getCompnayInfo() async throws -> CompanyProfileViewJSONResponse
}

@Observable
class DevCompanyProfileViewService: CompanyProfileViewServiceType {
    @MainActor
    func getCompnayInfo() async throws -> CompanyProfileViewJSONResponse {
        return try await getData(as: CompanyProfileViewJSONResponse.self, from: URLBuilder.activityFeed.url)
    }
}

@Observable
class OfflineCompanyProfileViewService: CompanyProfileViewServiceType {
    @MainActor
    func getCompnayInfo() async throws -> CompanyProfileViewJSONResponse {
        return try await getData(as: CompanyProfileViewJSONResponse.self, from: URLBuilder.activityFeed.url)
    }
}

protocol CompanyProfileViewViewModelType {
    var bio: String { get set }
    var team: [TeamMember] { get set }
    var projects: [Project] { get set }
    var logoImageUrl: String { get set }
    var coverImageUrl: String { get set }
    var coordinates: Coordinates { get set }
    var missionStatement: String { get set }
    var orginizationName: String { get set }
    var briefHistoryObject: BriefHistoryObject { get set }
    var activityFeedViewModel: ActivityFeedViewViewModelType { get set }
}

class DevCompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var bio: String
    var team: [TeamMember]
    var projects: [Project]
    var logoImageUrl: String
    var coverImageUrl: String
    var coordinates: Coordinates
    var missionStatement: String
    var orginizationName: String
    var briefHistoryObject: BriefHistoryObject
    var activityFeedViewModel: ActivityFeedViewViewModelType

    init(
        bio: String,
        team: [TeamMember],
        projects: [Project],
        logoImageUrl: String,
        coverImageUrl: String,
        coordinates: Coordinates,
        missionStatement: String,
        orginizationName: String,
        briefHistoryObject: BriefHistoryObject,
        activityFeedViewModel: ActivityFeedViewViewModelType)
    {
        self.bio = bio
        self.team = team
        self.projects = projects
        self.logoImageUrl = logoImageUrl
        self.coverImageUrl = coverImageUrl
        self.coordinates = coordinates
        self.missionStatement = missionStatement
        self.orginizationName = orginizationName
        self.briefHistoryObject = briefHistoryObject
        self.activityFeedViewModel = activityFeedViewModel
    }

    convenience init(company: CompanyObject) {
        let company: CompanyObject = CompanyObject.createFakeCompanyObject()
        let activityFeedViewModel = DevCompanyActivityFeed()
        self.init(
            bio: company.bio,
            team: company.team,
            projects: company.projects,
            logoImageUrl: company.logoImageUrl,
            coverImageUrl: company.coverImageUrl,
            coordinates: company.coordinates,
            missionStatement: company.missionStatement,
            orginizationName: company.orginizationName,
            briefHistoryObject: company.briefHistoryObject,
            activityFeedViewModel: activityFeedViewModel
        )
    }

}

class CompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var bio: String = ""
    var team: [TeamMember] = []
    var projects: [Project] = []
    var logoImageUrl: String = ""
    var coverImageUrl: String = ""
    var coordinates: Coordinates = Coordinates(latitude: 0, longitude: 0)
    var missionStatement: String = ""
    var orginizationName: String = ""
    var briefHistoryObject: BriefHistoryObject = BriefHistoryObject(history: "", imageObjects: [])
    var activityFeedViewModel: ActivityFeedViewViewModelType

    init(companyID: String) {
        self.activityFeedViewModel = CompanyActivityFeed(
            companyID: companyID,
            service: ActivityPostsService()
        )
    }

    convenience init(company: CompanyObject) {
        self.init(companyID: company.id)
        self.bio = company.bio
        self.team = company.team
        self.projects = company.projects
        self.logoImageUrl = company.logoImageUrl
        self.coverImageUrl = company.coverImageUrl
        self.coordinates = company.coordinates
        self.missionStatement = company.missionStatement
        self.orginizationName = company.orginizationName
        self.briefHistoryObject = company.briefHistoryObject
        self.activityFeedViewModel = CompanyActivityFeed(
            companyID: company.id,
            service: ActivityPostsService()
        )
    }
}

class OfflineCompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var bio: String = ""
    var team: [TeamMember] = []
    var projects: [Project] = []
    var logoImageUrl: String = ""
    var coverImageUrl: String = ""
    var coordinates: Coordinates = Coordinates(latitude: 0, longitude: 0)
    var missionStatement: String = ""
    var orginizationName: String = ""
    var briefHistoryObject: BriefHistoryObject = BriefHistoryObject(history: "", imageObjects: [])
    var activityFeedViewModel: ActivityFeedViewViewModelType
    var companyProfileViewService = OfflineCompanyProfileViewService()

    init(companyID: String) {
        self.activityFeedViewModel = CompanyActivityFeed(
            companyID: companyID,
            service: OfflineActivityPostsService()
        )
    }
}

struct CompanyProfileView: View {

    struct Constants {
        static let HeaderViewHeight: CGFloat = 200.0
        static let NavigationBarHeight: CGFloat = 50
        static let ScrollViewOffset: CGFloat = -50
    }

    enum ProfileTabs: Int, CaseIterable {
        case about, activity
    }

    enum AboutSections: Int, CaseIterable, Identifiable {

        case missionStatements
        case ourTeam
        case briefHistory
        case locations
        case projects

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

        func sectionDescriptionText(viewModel: CompanyProfileViewViewModelType) -> String? {
            switch self {
            case .missionStatements:
                viewModel.missionStatement
            case .ourTeam:
                nil
            case .briefHistory:
                viewModel.briefHistoryObject.history
            case .locations:
                viewModel.missionStatement
            case .projects:
                nil
            }
        }

        @ViewBuilder
        func sectionView(viewModel: CompanyProfileViewViewModelType) -> some View {
            switch self {
            case .missionStatements:
                // For some reason EmptyView() Buggs out the insets
                // So we go with this instead
                Divider().frame(height: .zero).opacity(.zero)
            case .ourTeam:
                OurTeamPhotoScrollerView(teamMembers: viewModel.team)
            case .briefHistory:
                BriefHistoryPhotoScrollerView(briefHistoryObject: viewModel.briefHistoryObject)
            case .locations:
                CompanyProfileMapView(
                    coordinate: viewModel.coordinates,
                    annotaionUrl: viewModel.logoImageUrl,
                    annotaionName: viewModel.orginizationName
                )
            case .projects:
                ProjectsScrollerView(projects: viewModel.projects)
            }
        }
    }

    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State var showActivityFeed: Bool = true
    @State private var currentTab: ProfileTabs = .about
    @State var showNavigationBar: Bool = false

    private let viewModel: CompanyProfileViewViewModelType

    init(viewModel: CompanyProfileViewViewModelType) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollViewOffset(onOffsetChange: { (offset) in
            handleNavigationBarAnimation(scrollViewOffset: offset)
        }) {
            GeometryReader { proxy in
                AsyncImage(url: URL(string: viewModel.coverImageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(y: -proxy.frame(in: .global).minY)
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: max(proxy.frame(in: .global).minY + Constants.HeaderViewHeight, 0)
                        )
                        .ignoresSafeArea()

                } placeholder: {
                    Color.gray
                        .offset(y: -proxy.frame(in: .global).minY)
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: max(proxy.frame(in: .global).minY + Constants.HeaderViewHeight, 0)
                        )
                        .ignoresSafeArea()
                }
            }
            .frame(height: Constants.HeaderViewHeight)
            .ignoresSafeArea()

            VStack(spacing: .zero) {
                VStack(spacing: 8) {
                    HStack {
                        AsyncImage(url: URL(string: viewModel.logoImageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: 75,
                                    height: 75
                                )
                                .clipShape(Circle())

                        } placeholder: {
                            Color.gray
                                .clipShape(Circle())
                        }
                        .frame(
                            width: 75,
                            height: 75
                        )
                        .overlay(Circle().stroke(.background, lineWidth: 3))

                        Spacer()

                        Text("DONATE")
                            .font(.system(size: 15))
                            .fontWeight(.semibold)
                            .padding([.vertical], 6)
                            .padding([.horizontal], 8)
                            .foregroundColor(.white)
                            .background(.regularMaterial.opacity(0.1))
                            .background(.red)
                            .environment(\.colorScheme, .dark)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 8)
                            )
                            .padding([.trailing], 8)
                            .offset(y: 20)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.orginizationName)
                            .font(.title2)
                            .bold()
                        Text("Current Projects: **\(viewModel.projects.count)**")

                        Text(viewModel.bio)
                            .font(.subheadline)
                    }
                    Picker("", selection: $currentTab) {
                        Text("ABOUT").tag(CompanyProfileView.ProfileTabs.about)
                        Text("RECENT ACTIVITY").tag(CompanyProfileView.ProfileTabs.activity)
                    }
                    .pickerStyle(.segmented)
                    .padding([.vertical], 8)

                    Divider()
                }
                .padding([.horizontal, .vertical], 16)
                .offset(y: Constants.ScrollViewOffset)

                switch currentTab {
                case .about:
                    ForEach(AboutSections.allCases) { section in
                        CompanyProfileTextView(
                            titleText: section.sectionTitles,
                            text: section.sectionDescriptionText(viewModel: viewModel),
                            mediaLocation: section.sectionMediaLocation
                        ) {
                            section.sectionView(viewModel: viewModel)
                        }
                    }
                    .offset(y: -50)
                case .activity:
                    ActivityFeedScrollView(
                        shouldShowCategoryFilter: false,
                        viewModel: viewModel.activityFeedViewModel
                    )
                    .offset(y: Constants.ScrollViewOffset)
                }
            }
            .background()
        }
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            BlurView()
                .ignoresSafeArea()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: Constants.NavigationBarHeight
                )
                .opacity(showNavigationBar ? 1 : 0)
                .overlay(alignment: .center) {
                    Text(viewModel.orginizationName)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .opacity(showNavigationBar ? 1 : 0)
                }
                .overlay(alignment: .leading) {
                    Image(systemName: "chevron.left")
                        .frame(width: 20,height: 20)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(
                            .background
                                .opacity(showNavigationBar ? 0 : 0.5)
                        )
                        .environment(\.colorScheme, .dark)
                        .clipShape(Circle())
                        .onTapGesture { dismiss() }
                        .padding([.horizontal])
                        .allowsHitTesting(true)
                }
        }
    }

    private func handleNavigationBarAnimation(scrollViewOffset: CGFloat) {
        if abs(scrollViewOffset) > Constants.HeaderViewHeight - Constants.NavigationBarHeight, !showNavigationBar, scrollViewOffset < 0 {
            withAnimation(.easeInOut(duration: 0.2)) {
                showNavigationBar.toggle()
            }
        } else if abs(scrollViewOffset) < Constants.HeaderViewHeight - Constants.NavigationBarHeight, showNavigationBar {
            withAnimation(.easeInOut(duration: 0.2)) {
                showNavigationBar.toggle()
            }
        }
    }

}

#Preview {
    CompanyProfileView(
        viewModel: DevCompanyProfileViewViewModel(company: CompanyObject.createFakeCompanyObject())
    )
}
