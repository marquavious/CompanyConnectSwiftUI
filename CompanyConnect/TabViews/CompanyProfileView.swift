//
//  CompanyProfileView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 11/30/23.
//

import SwiftUI
import MapKit

struct CompanyProfileView: View {

    struct Constants {
        static let HeaderViewHeight: CGFloat = 200.0
        static let NavigationBarHeight: CGFloat = 50
        static let ScrollViewOffset: CGFloat = -50
    }

    enum ProfileTabs: Int, CaseIterable {
        case about, activity
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

        func descriptionText(viewModel: CompanyProfileViewViewModelType) -> String? {
            switch self {
            case .missionStatement:
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
        func view(viewModel: CompanyProfileViewViewModelType) -> some View {
            switch self {
            case .missionStatement:
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
                    ForEach(AboutSection.allCases) { section in
                        CompanyProfileTextView(
                            titleText: section.title,
                            text: section.descriptionText(viewModel: viewModel),
                            mediaLocation: section.mediaPlacement
                        ) {
                            section.view(viewModel: viewModel)
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
