//
//  ActivityFeedTabView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import TipKit

typealias CompanyID =  String

struct ActivityFeedTabView: View {

    struct Constants {
        static let NavigationTitle = "Recent Updates"
        static let AnimationDuration: CGFloat = 0.2
    }

    enum Icons: String {
        case RightToolBarIcon = "xmark.circle"
    }

    @Environment (\.colorScheme) var colorScheme
    @State private var presentedNgos: [CompanyID] = []
    @State private var shouldShowFilter: Bool = false

    var viewModel: ActivityFeedViewViewModelType

    var body: some View {
        NavigationStack(path: $presentedNgos) {
            switch viewModel.loadingState {
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
//                .navigationDestination(for: CompanyObject.self) {
////                    CompanyProfileView(
//                    /*CompanyProfileView*/(viewModel: any CompanyProfileViewViewModelType)
////                    CompanyProfileView(
////                        viewModel: CompanyProfileViewViewModel(
////                            companyID: $0, companyProfileViewService: any CompanyProfileViewServiceType
////                        )
////                    )
//                }
                .navigationTitle(Constants.NavigationTitle)
                .toolbar {
                    Button(
                        String(),
                        systemImage: viewModel.hasSelectedCategories() ? Icons.RightToolBarIcon.rawValue : String()
                    ) {
                        if viewModel.hasSelectedCategories() {
                            withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                                viewModel.resetSelectedCategories()
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
        .task {
            if viewModel.loadingState != .fetched {
                await fetchPost()
            }
        }
    }

    private func fetchPost() async {
        await viewModel.loadPosts()
    }
}

#Preview {
    ActivityFeedTabView(
        viewModel: DevHomeTabActivityFeed(postCount: 5, loadingState: .fetched)
    )
}
