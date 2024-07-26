//
//  ActivityFeedView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import AVKit
import TipKit

struct ActivityFeedView: View {

    struct Constants {
        static let NavigationTitle = "Recent Updates"
        static let AnimationDuration: CGFloat = 0.2
    }

    enum Icons: String {
        case RightToolBarIcon = "xmark.circle"
    }

    @Environment (\.colorScheme) var colorScheme
    @State private var presentedNgos: [CompanyObject] = []
    @State private var shouldShowFilter: Bool = false

    var viewModel: ActivityFeedViewViewModelType

    var body: some View {
        NavigationStack(path: $presentedNgos) {
            ActivityFeedScrollView(
                shouldShowCategoryFilter: true,
                viewModel: viewModel
            ){
                presentedNgos.append($0)
            }
            .navigationDestination(for: CompanyObject.self) {
                CompanyProfileView(viewModel: CompanyProfileViewViewModel(company: $0))
            }
            .task {
                await viewModel.loadPosts()
            }
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
        }
    }

}

#Preview {
    ActivityFeedView(
        viewModel: DevHomeTabActivityFeed()
    )
}
