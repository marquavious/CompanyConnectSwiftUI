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

    private let columns = [GridItem(.flexible())]
    private let activityScrollerTipView = ActivityScrollerTipView()

    var onCompanySelection: ((String) -> Void)?
    var reachedEndOfScrollview: (() -> Void)?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVGrid(
                    columns: columns,
                    alignment: .leading, pinnedViews: [.sectionHeaders]
                ) {
                    Section {
                        TipView(activityScrollerTipView).padding([.horizontal], Constants.TipViewPadding)
                        EmptyView()
                            .frame(height: 0)
                            .id("top_of_scroll_view")
                        ForEach(0..<activityPostsManager.filteredPosts.count, id: \.self) { index in
                            let post = activityPostsManager.filteredPosts[index]
                            PostCellView(activityPost: post) {
                                onCompanySelection?(post.id)
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
            .safeAreaInset(edge: .top, spacing: 0) {
                VStack(spacing: .zero) {
                    if shouldShowCategoryFilter {
                        ActvitiyFeedFilterView { category in
                            withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                                activityPostsManager.categoryManager.handleCategorySelection(category: category)
                            }
                        }
                        .environmentObject(activityPostsManager.categoryManager)
                        .frame(height: Constants.ActvitiyFeedFilterViewHight)
                        .background(Material.ultraThin)
                        Divider()
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                if activityPostsManager.categoryManager.hasSelectedCategories {
                    Button {
                        withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                            activityPostsManager.categoryManager.resetSelectedCategories()
                        }
                    } label: {
                        Text(Image(systemName: "line.3.horizontal.decrease.circle"))
                            .overlay {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                    .overlay {
                                        Image(systemName: "line.diagonal")
                                            .rotationEffect(.degrees(90))
                                    }
                            }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }.onChange(of: activityPostsManager.categoryManager.selctedCategories) { _, _ in
                withAnimation(.easeIn(duration: 0.2)) {
                    proxy.scrollTo("top_of_scroll_view")
                }
            }
        }
    }
}

#Preview {
    ActivityFeedTabView()
}
