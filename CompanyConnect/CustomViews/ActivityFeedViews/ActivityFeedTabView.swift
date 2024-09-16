//
//  ActivityFeedTabView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import TipKit
import Factory
import FirebaseFirestore

struct ActivityFeedTabView: View {
    struct Constants {
        static let NavigationTitle = "Recent Updates"
        static let AnimationDuration: CGFloat = 0.2
    }

    enum Icons: String {
        case RightToolBarIcon = "xmark.circle"
    }

    enum FeedMode: CaseIterable {
        case list, gallery

        var title: String {
            switch self {
            case .list:
                "List"
            case .gallery:
                "Gallery"
            }
        }

        var iconString: String {
            switch self {
            case .list:
                "square.fill.text.grid.1x2"
            case .gallery:
                "square.grid.3x2"
            }
        }
    }

    @State private var presentedNgos: [String] = []
    @State private var shouldShowFilter: Bool = false
    @State private var loadingState: LoadingState = .loading
    @State private var filterIsActive: Bool = false
    @Environment (\.colorScheme) var colorScheme
    @StateObject var postsFilter: PostsManager = PostsManager()

    @State var feedMode: FeedMode = .list

    @Injected(\.activityServiceType) var service

    @ToolbarContentBuilder
    private var toolbarView: some ToolbarContent {
        ToolbarTitleMenu {
            ForEach(FeedMode.allCases, id: \.title) { mode in
                Button {
                    withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                        feedMode = mode
                    }
                } label: {
                    HStack {
                        Text("\(mode.title)\(mode == feedMode ? " •" : "")")
                        Image(systemName: mode.iconString)
                    }
                }
            }
        }
    }

    var body: some View {
        NavigationStack(path: $presentedNgos) {
            Group {
                switch loadingState {
                case .loading:
                    VStack(spacing: 0) {
                        BasicLoadingView(
                            titleString: "Loading Activtiy Posts...",
                            background: Color.white
                        )
                    }
                    .task {
                        if loadingState != .fetched {
                            await fetchPosts(forPagination: false)
                        }
                    }
                case .fetched:
                    Group {
                        switch feedMode {
                        case .list:
                            ActivityFeedScrollView(shouldShowCategoryFilter: true) { id in
                                presentedNgos.append(id)
                            } reachedEndOfScrollview: {
                                if !postsFilter.categoryManager.hasSelectedCategories {
                                    Task { await fetchPosts(forPagination: true) }
                                }
                            }
                            .environmentObject(postsFilter)
                            .navigationDestination(for: String.self) {
                                CompanyProfileView(companyID: $0)
                            }
                        case .gallery:
                            GalleryView()
                                .environmentObject(postsFilter)
                        }
                    }
                    .toolbarBackground(.hidden, for: .navigationBar)
                    .navigationTitle(Constants.NavigationTitle)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        toolbarView
                    }
                    .toolbar {
                        if postsFilter.categoryManager.hasSelectedCategories {
                            Button {
                                withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                                    postsFilter.categoryManager.resetSelectedCategories()
                                }
                            } label: {
                                Text(Image(systemName: "line.3.horizontal.decrease.circle"))
                                    .overlay {
                                        Image(systemName: "line.3.horizontal.decrease.circle")
                                            .overlay {
                                                Image(systemName: "line.diagonal")
                                                    .rotationEffect(.degrees(90))
                                            }
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .safeAreaInset(edge: .top, spacing: 0) {
                        VStack(spacing: .zero) {
                            ActvitiyFeedFilterView { category in
                                withAnimation(.easeInOut(duration: ActivityFeedScrollView.Constants.AnimationDuration)) {
                                    postsFilter.categoryManager.handleCategorySelection(category: category)
                                }
                            }
                            .frame(height: ActivityFeedScrollView.Constants.ActvitiyFeedFilterViewHight)
                            .background(Material.ultraThin)
                            .environmentObject(postsFilter.categoryManager)
                            Divider()
                        }
                    }

                case .error(let error):
                    BasicErrorView(
                        errorString: error.localizedDescription,
                        background: Color.white,
                        retryAction: { Task { await fetchPosts(forPagination: false) } }
                    )
                }
            }
        }
    }

    private func fetchPosts(forPagination: Bool) async {
        if !forPagination {
            loadingState = .loading
        }
        do {
            let response = try await service.getPosts()
            postsFilter.appendPosts(posts: response.activityPosts)
            loadingState = .fetched
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
               nsError.code == NSURLErrorCancelled {
                //Handle cancellation
            } else {
                loadingState = .error(error)
            }
        }
    }
}

#Preview {
    ActivityFeedTabView()
}

struct GalleryView: View {

    @EnvironmentObject var activityPostsManager: PostsManager

    let columns = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(activityPostsManager.allMediaPosts) { post in
                    if let media = post.media {
                        switch media {
                        case .photo(let photoUrl):
                            AsyncImage(url: URL(string: photoUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(height: UIScreen.main.bounds.width / 3)
                        case .photoCarousel(let carousel):
                            AsyncImage(url: URL(string: carousel.first!.imageUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray
                            }.overlay(alignment: .bottomLeading) {
                                Image(systemName: "photo.stack.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding(3)
                                    .tint(.white)
                            }
                            .frame(height: UIScreen.main.bounds.width / 3)
                        case .donationProgress:
                            fatalError("Should never exicute")
                        }
                    }
                }
            }
        }
    }
}

extension Color {
    static func random() -> Color {
        return Color(UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        ))
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
