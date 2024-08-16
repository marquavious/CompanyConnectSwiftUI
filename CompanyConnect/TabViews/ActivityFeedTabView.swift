//
//  ActivityFeedTabView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import TipKit

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
    @State private var loadingState: LoadingState
    @State private var categoryHandler: CategoryHandler = CategoryHandler()

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
            case .fetched:
                ActivityFeedScrollView(
                    shouldShowCategoryFilter: true,
                    viewModel: viewModel
                ){
                    presentedNgos.append($0)
                }
                .navigationDestination(for: String.self) {
                    CompanyProfileView(companyID: $0)
                }
                .navigationTitle(Constants.NavigationTitle)
                .toolbar {
                    Button(
                        String(),
                        systemImage: categoryHandler.hasSelectedCategories ? Icons.RightToolBarIcon.rawValue : String()
                    ) {
                        if categoryHandler.hasSelectedCategories {
                            withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                                categoryHandler.resetSelectedCategories()
                            }
                        }
                    }
                    .tint(colorScheme == .light ? .black : .white)
                }
            case .error:
                Text("OH NO LMFAOO :)")
                    .navigationTitle(Constants.NavigationTitle)
            }
        }
//        .task {
//            if loadingState != .fetched {
//                await fetchPost()
//            }
//        }
    }

//    private func fetchPost() async {
//        await viewModel.loadPosts()
//    }
}

//#Preview {
//    ActivityFeedTabView(viewModel: DevHomeTabActivityFeed(postCount: 5, loadingState: .fetched)
//    )
//}
