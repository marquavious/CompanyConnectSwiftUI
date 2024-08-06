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

        func descriptionText(company: CompanyObject) -> String? {
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
        func view(compnay: CompanyObject) -> some View {
            switch self {
            case .missionStatement:
                // For some reason EmptyView() Buggs out the insets
                // So we go with this instead
                Divider().frame(height: .zero).opacity(.zero)
            case .ourTeam:
                OurTeamPhotoScrollerView(teamMembers: compnay.team)
            case .briefHistory:
                BriefHistoryPhotoScrollerView(briefHistoryObject: compnay.briefHistoryObject)
            case .locations:
                CompanyProfileMapView(
                    coordinate: compnay.coordinates,
                    annotaionUrl: compnay.logoImageUrl,
                    annotaionName: compnay.orginizationName
                )
            case .projects:
                ProjectsScrollerView(projects: compnay.projects)
            }
        }
    }

    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) var colorScheme
    @State var showActivityFeed: Bool = true
    @State private var currentTab: ProfileTabs = .about
    @State var showNavigationBar: Bool = false

    private let viewModel: CompanyProfileViewViewModelType
    let companyID: String

    init(viewModel: CompanyProfileViewViewModelType, companyID: String) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)
        self.viewModel = viewModel
        self.companyID = companyID
    }

    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading, .idle:
                Rectangle()
                    .fill(.background)
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .opacity(0.9).overlay {
                        VStack(spacing: 0) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(width: 50, height: 50)
                            Text("Loading Comapny Data...")
                                .foregroundColor(.gray)
                        }
                        .task {
                            switch viewModel.loadingState {
                            case .loading:
                                break
                            case .fetched:
                                break
                            case .error:
                                break
                            case .idle:
                                await viewModel.loadCompanyProfile(companyID: companyID)
                            }
                        }
                    }
            case .fetched(let company):

                ScrollViewOffset(onOffsetChange: { (offset) in
                    handleNavigationBarAnimation(scrollViewOffset: offset)
                }) {
                    GeometryReader { proxy in
                        AsyncImage(url: URL(string: company.coverImageUrl)) { image in
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
                                AsyncImage(url: URL(string: company.logoImageUrl)) { image in
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
                            ForEach(AboutSection.allCases) { section in
                                CompanyProfileTextView(
                                    titleText: section.title,
                                    text: section.descriptionText(company: company),
                                    mediaLocation: section.mediaPlacement
                                ) {
                                    section.view(compnay: company)
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

            case .error:
                Text("OH NO LMFAOO :)")
            }
        }
        .navigationBarHidden(true)

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

//#Preview {
//    CompanyProfileView()
//}
