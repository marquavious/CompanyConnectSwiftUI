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

    var viewModel: ActivityFeedViewViewModelType
    @Environment (\.colorScheme) var colorScheme
    @State private var presentedNgos: [CompanyObject] = []
    @State private var shouldShowFilter: Bool = false

    var body: some View {
        NavigationStack(path: $presentedNgos) {
            ActivityFeedScrollView(
                shouldShowCategoryFilter: true,
                viewModel: viewModel
            ) { presentedNgos.append($0) }
            .navigationTitle("Recent Updates")
            .navigationDestination(for: CompanyObject.self) { company in
                NGOProfileView(companyObject: company)
                    .navigationBarBackButtonHidden(true)
            }
            .toolbar {
                Button("", systemImage: viewModel.hasSelected() ?  "xmark.circle": "") {
                    if viewModel.hasSelected() {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            viewModel.resetSelectedCategories()
                        }
                    }
                }.tint(colorScheme == .light ? .black:.white)
            }
        }
    }
}

#Preview {
    ActivityFeedView(viewModel: BasicFakeActivityFeed())
}

struct ActvitiyFeedFilterView: View {

    var viewModel: ActivityFeedViewViewModelType
    var onTapAction: ((Category) -> Void)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(viewModel.categories(), id: \.self) { category in
                    ZStack {
                        RoundButtonView(
                            text: category.name,
                            color: category.color,
                            isHighlighted: viewModel.selctedCategories().contains(category)
                        ) {
                            onTapAction(category)
                        }
                    }
                }
            }
        }
        .background(.background)
        .contentMargins(.horizontal, 8)
        .contentMargins(.vertical, 8)
    }
}

struct ActivityFeedScrollView: View {

    @State var shouldShowCategoryFilter: Bool

    var viewModel: ActivityFeedViewViewModelType
    @Environment(\.colorScheme) var colorScheme
    let activityScrollerTipView = ActivityScrollerTipView()

    var ngoSelected: ((CompanyObject) -> Void)?

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading, pinnedViews: [.sectionHeaders]) {
                Section {
                    TipView(activityScrollerTipView)
                        .padding([.horizontal], 16)
                    ForEach(viewModel.presentedPosts()) { activityPost in
                        HStack(alignment: .top, spacing: 12) {
                            if let poster = activityPost.poster {
                                poster.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .onTapGesture { ngoSelected?(activityPost.company) }
                                    /*
                                    .overlay(alignment: .bottomTrailing) {
                                        LogoImageView(
                                            logoImageViewData: activityPost.company.logoImageData,
                                            showIconOnly: true, size: CGSize(width: 20, height: 20)
                                        )
                                        .offset(x:8, y: 8)
                                    }
                                 */
                            } else {
                                LogoImageView(
                                    logoImageViewData: activityPost.company.logoImageData,
                                    showIconOnly: true, size: CGSize(width: 40, height: 40)
                                )
                            }

                            VStack(alignment: .leading, spacing: 6) {
                                HStack(spacing: 0) {
                                    if let poster = activityPost.poster {
                                        Text("\(poster.name)")
                                            .font(.subheadline)
                                            .bold()

                                        Text(" from ")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }

                                    Text(activityPost.company.orginizationName)
                                        .font(.subheadline)
                                        .bold()
                                        .fixedSize(horizontal: false, vertical: true)

                                    Text(" • \(activityPost.hourAgoPosted)h")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)

                                    Spacer()

                                    Menu {
                                        Button("Share", systemImage: "square.and.arrow.up") { }
                                        Button("Visit Profile", systemImage: "person.crop.circle") {
                                            if let ngoSelected {
                                                ngoSelected(activityPost.company)
                                            }
                                        }
                                    } label: {
                                        Label("", systemImage: "ellipsis")
                                            .tint(colorScheme == .light ? .black:.white)
                                    }
                                }

                                if let caption = activityPost.caption {
                                    Text(caption)
                                        .font(.system(size: 14))
                                        .padding([.bottom], 8)
                                }


//                                if let media = activityPost.media {
//                                    MediaView(media: media)
//                                        .padding([.vertical], 8)
//                                        .frame(width: 200, height: 200)
//                                }
                            }
                        }
                        .padding([.top], 8)
                        .padding([.horizontal], 16)
                        Divider()
                    }
                } header: {
                        if shouldShowCategoryFilter {
                            VStack(spacing: 0) {
                            ActvitiyFeedFilterView(viewModel: viewModel) { category in
                                activityScrollerTipView.invalidate(reason: .actionPerformed)
                                if viewModel.selctedCategories().contains(category) {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        viewModel.removeCategory(category: category)
                                    }
                                } else if !viewModel.selctedCategories().contains(category) {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        viewModel.addToSelectedCategories(category: category)
                                    }
                                }
                            }
                            .frame(minHeight: 50)
                                Divider()
                        }
                    }
                }
            }
        }
    }
}
