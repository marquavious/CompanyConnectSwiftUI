//
//  ActivityFeedTabView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import TipKit
import Factory

struct ActivityFeedTabView: View {
    struct Constants {
        static let NavigationTitle = "Recent Updates"
        static let AnimationDuration: CGFloat = 0.2
    }

    enum Icons: String {
        case RightToolBarIcon = "xmark.circle"
    }

    @State private var presentedNgos: [String] = []
    @State private var shouldShowFilter: Bool = false
    @State private var loadingState: LoadingState = .loading
    @State private var filterIsActive: Bool = false
    @Environment (\.colorScheme) var colorScheme
    @StateObject var postsFilter: PostsManager = PostsManager()

    @Injected(\.activityServiceType) var service

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
                            await fetchPosts()
                        }
                    }
                case .fetched:
                    ActivityFeedScrollView(
                        shouldShowCategoryFilter: true
                    ){
                        presentedNgos.append($0)
                    }
                    .environmentObject(postsFilter)
                    .navigationDestination(for: String.self) {
                        CompanyProfileView(companyID: $0)
                    }
                case .error(let error):
                    BasicErrorView(
                        errorString: error.localizedDescription,
                        background: Color.white,
                        retryAction: { Task { await fetchPosts() } }
                    )
                }
            }
            .navigationTitle(Constants.NavigationTitle)
        }
    }

    private func fetchPosts() async {
        loadingState = .loading
        do {
            let response = try await service.getPosts()
            postsFilter.setPosts(posts: response.activityPosts)
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
