//
//  CompanyProfileView.swift
//  SwfitUI Connect And Care
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

        func sectionDescriptionText(companyObject: CompanyObject) -> String? {
            switch self {
            case .missionStatements:
                companyObject.missionStatement
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
                // For some reason EmptyView() Buggs out the insets
                // So we go with this instead
                Divider()
                    .frame(height: .zero)
                    .opacity(.zero)
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
    @State var showNavigationBar: Bool = false

    private var viewModel: ActivityFeedViewViewModelType
    private let company: CompanyObject

    init(companyObject: CompanyObject) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
        self.company = companyObject
        self.viewModel = CompanyActivityFeed(company: companyObject)
    }

    var body: some View {
        ScrollViewOffset(onOffsetChange: { (offset) in
            handleNavigationBarAnimation(scrollViewOffset: offset)
        }) {
            GeometryReader { proxy in
                company.coverImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -proxy.frame(in: .global).minY)
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: max(proxy.frame(in: .global).minY + Constants.HeaderViewHeight, 0)
                    )
            }
            .frame(height: Constants.HeaderViewHeight)
            .ignoresSafeArea()

            VStack(spacing: .zero) {
                VStack(spacing: 8) {
                    HStack {
                        LogoImageView(
                            logoImageViewData: company.logoImageData,
                            size: CGSize(width: 75, height: 75),
                            overrideLogoWithFontSize: .largeTitle
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
                        Text(company.orginizationName)
                            .font(.title2)
                            .bold()
                        Text("Current Projects: **\(company.projects.count)**")

                        Text(company.bio)
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
                            text: section.sectionDescriptionText(companyObject: company),
                            mediaLocation: section.sectionMediaLocation
                        ) {
                            section.sectionView(companyObject: company)
                        }
                    }
                    .offset(y: -50)
                case .activity:
                    ActivityFeedScrollView(
                        shouldShowCategoryFilter: false,
                        viewModel: viewModel
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
                    Text(company.orginizationName)
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
    CompanyProfileView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
