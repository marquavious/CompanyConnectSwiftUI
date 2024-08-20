//
//  CompanyProfileView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 11/30/23.
//

import SwiftUI
import MapKit
import Factory

struct CompanyProfileView: View {

    struct Constants {
        static let HeaderViewHeight: CGFloat = 200.0
        static let NavigationBarHeight: CGFloat = 50
        static let ScrollViewOffset: CGFloat = -50
        static let CompanyProfilePictureSize: CGSize = CGSize(width: 75, height: 75)
    }

    @State private var showActivityFeed: Bool = true
    @State private var currentTab: ProfileTabs = .about
    @State private var showNavigationBar: Bool = false
    @State private var loadingState: LoadingState
    @StateObject private var activityPostsManager = PostsManager()

    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Injected(\.profileServiceType) var profileService
    @Injected(\.activityServiceType) var activityService

    private var companyID: String

    init(companyID: String) {
        self.companyID = companyID
        loadingState = .loading
        adjustPageIndicatorTintColor()
    }

    init(companyObject: Company) {
        self.companyID = companyObject.id
        loadingState = .fetched(companyObject)
        adjustPageIndicatorTintColor()
    }

    var body: some View {
        Group {
            switch loadingState {
            case .loading:
                BasicLoadingView(
                    titleString: "Loading Company Data...",
                    background: Color.white
                )
                .task {
                    await loadCompanyProfileData()
                }
            case .fetched(let company):
                ScrollViewOffset(onOffsetChange: { (offset) in
                    handleNavigationBarAnimation(scrollViewOffset: offset)
                }) {
                    StretchyHeaderURLView(
                        headerViewHeight: Constants.HeaderViewHeight,
                        url: company.coverImageUrl
                    )

                    VStack(spacing: .zero) {
                        CompanyProfileCompanyDetailsView(
                            company: company,
                            currentTab: $currentTab
                        )

                        switch currentTab {
                        case .about:
                            ForEach(AboutSection.allCases) { section in
                                CompanyProfileTextView(
                                    titleText: section.title,
                                    text: section.descriptionText(company: company),
                                    mediaLocation: section.mediaPlacement
                                ) {
                                    section.mediaView(company: company)
                                }
                            }
                        case .recentActivity:
                            ZStack {
                                ProgressView() // TODO: - The logic isn't right for this to be showing when needed.
                                ActivityFeedScrollView(shouldShowCategoryFilter: false)
                                    .environmentObject(activityPostsManager)
                                    .frame(minHeight: UIScreen.main.bounds.height / 2)
                                    .task {
                                        await loadRecentActivity()
                                    }
                            }
                        }
                    }
                    .offset(y: Constants.ScrollViewOffset)
                }
                .navigationBarBackButtonHidden(true)
                .overlay(alignment: .topLeading) {
                    DarkThemedNavBarView(
                        title: company.orginizationName,
                        showNavigationBar: $showNavigationBar
                    )
                }

            case .error(let error):
                BasicErrorView(
                    errorString: error.localizedDescription,
                    background: Color.white,
                    retryAction: { Task { await loadCompanyProfileData() } }
                )
            }
        }
        .navigationBarHidden(true)
    }

    private func loadCompanyProfileData() async {
        loadingState = .loading
        do {
            let response = try await profileService.getCompnayInfo(companyID: companyID)
            loadingState = .fetched(response.companyObject)
        } catch {
            handleError(error: error)
        }
    }

    private func loadRecentActivity() async {
        do {
            let response = try await activityService.getPostsFromCompanyWithID(companyID)
            activityPostsManager.setPosts(posts: response.activityPosts)
        } catch {
            handleError(error: error)
        }
    }

    private func handleError(error: Error) {
        loadingState = .error(error)

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

    private func adjustPageIndicatorTintColor() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
    }
}

#Preview {
    CompanyProfileView(companyObject: Company.createFakeCompanyObject())
}
