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


enum ActivityFeedScrollViewEvent {
    case onCompanySelection(companyID: String)
    case onSelect(categoryHandler: CategoryHandler)
}

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
    @Binding var posts: [ActivityPost]
    @EnvironmentObject var categoryHandler: CategoryHandler

    private let columns = [GridItem(.flexible())]
    private let activityScrollerTipView = ActivityScrollerTipView()

    var scrollViewEvent: (ActivityFeedScrollViewEvent) -> Void

    var body: some View {

        ScrollView(showsIndicators: false) {
            LazyVGrid(
                columns: columns,
                alignment: .leading, pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    TipView(activityScrollerTipView).padding([.horizontal], Constants.TipViewPadding)
                    ForEach(posts) { activityPost in
                        ActivityCellView(activityPost: activityPost) {
                            scrollViewEvent(.onCompanySelection(companyID: activityPost.company.id))
                        }

                        Divider()
                    }
                } header: {
                    if shouldShowCategoryFilter {
                        VStack(spacing: .zero) {
                            ActvitiyFeedFilterView() { category in
                                withAnimation {
                                    
                                    categoryHandler.handleCategorySelection(category: category)
                                }
                            }
                            .environmentObject(categoryHandler)
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
    }

}

//#Preview {
//    ActivityFeedTabView(coordinator: DevNavigationCoordinator(), viewModel: DevHomeTabActivityFeed())
//}
