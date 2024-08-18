//
//  ActivityFeedScrollView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/16/24.
//

import Foundation
import SwiftUI
import TipKit
import Factory

struct ActivityFeedScrollView: View {

    struct Constants {
        static let TipViewPadding: CGFloat = 16
        static let ActvitiyFeedFilterViewHight: CGFloat = 50
        static let AnimationDuration: CGFloat = 0.2
    }

    enum Icons: String {
        case RightToolBarIcon = "xmark.circle"
    }

    @State var shouldShowCategoryFilter: Bool
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var activityPostsManager: ActivityPostsManager

    private let columns = [GridItem(.flexible())]
    private let activityScrollerTipView = ActivityScrollerTipView()

    var onCompanySelection: ((String) -> Void)?

    var body: some View {

        ScrollView(showsIndicators: false) {
            LazyVGrid(
                columns: columns,
                alignment: .leading, pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    TipView(activityScrollerTipView).padding([.horizontal], Constants.TipViewPadding)
                    ForEach(activityPostsManager.filteredPosts) { activityPost in
                        ActivityCellView(activityPost: activityPost) {
                            onCompanySelection?(activityPost.id)
                        }

                        Divider()
                    }
                } header: {
                    if shouldShowCategoryFilter {
                        VStack(spacing: .zero) {
                            ActvitiyFeedFilterView() { category in
                                withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                                    activityPostsManager.categoryFilter.handleCategorySelection(category: category)
                                }
                            }
                            .environmentObject(activityPostsManager.categoryFilter)
                            .frame(minHeight: Constants.ActvitiyFeedFilterViewHight)

                            Divider()
                        }
                    }
                }
            }
        }
        .toolbar {
            Button(
                String(),
                systemImage: activityPostsManager.categoryFilter.hasSelectedCategories ? Icons.RightToolBarIcon.rawValue : String()
            ) {
                if activityPostsManager.categoryFilter.hasSelectedCategories {
                    withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                        activityPostsManager.categoryFilter.resetSelectedCategories()
                    }
                }
            }
            .tint(colorScheme == .light ? .black : .white)
        }
    }

}

//#Preview {
//    ActivityFeedTabView(coordinator: DevNavigationCoordinator(), viewModel: DevHomeTabActivityFeed())
//}
