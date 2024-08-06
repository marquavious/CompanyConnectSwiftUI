//
//  ActivityFeedScrollView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/16/24.
//

import Foundation
import SwiftUI
import TipKit

struct ActivityFeedScrollView: View {

    struct Constants {
        static let TipViewPadding: CGFloat = 16
        static let ActvitiyFeedFilterViewHight: CGFloat = 50
        static let AnimationDuration: CGFloat = 0.2
    }

    @State var shouldShowCategoryFilter: Bool
    @Environment(\.colorScheme) var colorScheme

    var viewModel: ActivityFeedViewViewModelType
    var ngoSelected: ((_ companyID: String) -> Void)?
    private let columns = [GridItem(.flexible())]
    private let activityScrollerTipView = ActivityScrollerTipView()

    var body: some View {

        ScrollView(showsIndicators: false) {
            LazyVGrid(
                columns: columns,
                alignment: .leading, pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    TipView(activityScrollerTipView)
                        .padding([.horizontal], Constants.TipViewPadding)
                    ForEach(viewModel.presentedPosts()) { activityPost in
                        ActivityCellView(activityPost: activityPost) {
                            ngoSelected?(activityPost.company.id)
                        }

                        Divider()
                    }
                } header: {
                    if shouldShowCategoryFilter {
                        VStack(spacing: .zero) {
                            ActvitiyFeedFilterView(viewModel: viewModel) { category in
                                activityScrollerTipView.invalidate(reason: .actionPerformed)
                                withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                                    viewModel.handleCategorySelection(category)
                                }
                            }
                            .frame(minHeight: Constants.ActvitiyFeedFilterViewHight)

                            Divider()
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    ActivityFeedTabView(coordinator: DevNavigationCoordinator(), viewModel: DevHomeTabActivityFeed())
}
