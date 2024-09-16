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
    @EnvironmentObject var activityPostsManager: PostsManager
    @EnvironmentObject var timelineMarker: TimelineMarker

    private let columns = [GridItem(.flexible())]
    private let activityScrollerTipView = ActivityScrollerTipView()

    var onCompanySelection: ((String) -> Void)?
    var reachedEndOfScrollview: (() -> Void)?

    var body: some View {
        ScrollView(showsIndicators: true) {
            LazyVGrid(
                columns: columns,
                alignment: .leading, pinnedViews: [.sectionHeaders]
            ) {
                Section {
                    TipView(activityScrollerTipView).padding([.horizontal], Constants.TipViewPadding)
                    ForEach(0..<activityPostsManager.filteredPosts.count, id: \.self) { index in
                        let post = activityPostsManager.filteredPosts[index]
                        PostCellView(activityPost: post) {
                            onCompanySelection?(post.id)
                        }
                        .id(index)
                        .onAppear {
                            timelineMarker.setIdIfGreaterThan(id: index)
                        }

                        Divider()

                        // TODO: - FIX THIS LOGIC WITH CATEGORY SEARCH
                        if index+1 == activityPostsManager.filteredPosts.count,
                           !activityPostsManager.categoryManager.hasSelectedCategories {
                            Rectangle()
                                .fill(.background)
                                .frame(width: UIScreen.main.bounds.width, height: 100)
                                .overlay {
                                    ProgressView()
                                }
                                .onAppear {
                                    reachedEndOfScrollview?()
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ActivityFeedTabView()
}
