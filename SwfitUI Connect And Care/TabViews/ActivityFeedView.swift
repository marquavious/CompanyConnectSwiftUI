//
//  ActivityFeedView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import AVKit
import TipKit

struct ActivityFeedView: View {

    struct Constants {
        static let navigationTitle = "Recent Updates"
        static let AnimationDuration: CGFloat = 0.2
    }

    enum Icons: String {
        case rightToolBarIcon = "xmark.circle"
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
                NGOProfileView(companyObject: $0)
            }
            .navigationTitle(Constants.navigationTitle)
            .toolbar {
                Button(String(),systemImage: viewModel.hasSelectedCategories() ? Icons.rightToolBarIcon.rawValue : String()) {
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
    ActivityFeedView(viewModel: BasicFakeActivityFeed())
}
