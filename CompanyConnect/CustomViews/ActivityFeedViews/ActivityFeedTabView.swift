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

    enum LoadingState: Equatable {
        case loading
        case fetched
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

    struct Constants {
        static let NavigationTitle = "Recent Updates"
        static let AnimationDuration: CGFloat = 0.2
    }

    enum Icons: String {
        case RightToolBarIcon = "xmark.circle"
    }

    @Environment (\.colorScheme) var colorScheme
    @State private var presentedNgos: [String] = []
    @State private var shouldShowFilter: Bool = false
    @State private var loadingState: LoadingState = .loading
    @State private var filterIsActive: Bool = false
    @StateObject var postsFilter: PostsManager = PostsManager()

    @Injected(\.activityServiceType) var service

    var body: some View {
        NavigationStack(path: $presentedNgos) {
            switch loadingState {
            case .loading:
                VStack(spacing: 0) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 50, height: 50)
                    Text("Loading Activtiy Posts...")
                        .foregroundColor(.gray)
                }
                .navigationTitle(Constants.NavigationTitle)
                .task {
                    if loadingState != .fetched {
                        await fetchPost()
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
                .navigationTitle(Constants.NavigationTitle)
            case .error:
                Text("OH NO LMFAOO :)")
                    .navigationTitle(Constants.NavigationTitle)
            }
        }
    }

    private func fetchPost() async {
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
