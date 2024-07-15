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

    @StateObject var viewModel = BasicFakeActivityFeed()
    @Environment (\.colorScheme) var colorScheme
    @State private var presentedNgos: [CompanyObject] = []
    @State private var shouldShowFilter: Bool = false

    var body: some View {
        NavigationStack(path: $presentedNgos) {
            ActivityFeedScrollView(shouldShowCategoryFilter: true, viewModel: viewModel, ngoSelected: { ngo in
                presentedNgos.append(ngo)
            }, actvityPostSelected: { post in
            })
            .environment(viewModel)
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

struct MediaView: View {
    let media: ActvityPost.Media
    let padding: CGFloat = 8.0

    @Environment (\.colorScheme) var colorScheme

    var body: some View {
        switch media {
        case .photo(let photo):
                photo.image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .contextMenu {
                        Button("Share", systemImage: "square.and.arrow.up") { }
                    }
                    .shadow(radius: colorScheme == .light ? 1 : 0)

        case .photos(let images):
            GeometryReader { proxy in
                let proxySize = proxy.frame(in: .local)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        ForEach(images, id: \.id) { image in
                            image.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: proxySize.width - (padding * 2),
                                       height: proxySize.height,
                                       alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .contextMenu {
                                    Button("Share", systemImage: "square.and.arrow.up") { }
                                }
                                .shadow(radius: colorScheme == .light ? 1 : 0)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollClipDisabled()
                .scrollTargetBehavior(.viewAligned)
            }.frame(height: 200)
        case .donationProgress(let donationProgress, let donationTotal):
            GeometryReader { proxy in
                let width: CGFloat = proxy.frame(in: .local).width
                let height: CGFloat = 15
                let percent = (( donationProgress / donationTotal) * 100)
                let color1 = Color(Color.orange)
                let color2 = Color(Color.red)

                let multiplier = width / 100

                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        Text("$\(String(format: "%.0f", donationProgress))")
                            .font(.title)

                        Text("/ $\(String(format: "%.0f", donationTotal))")
                            .font(.title)
                            .opacity(0.5)
                    }

                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: height, style: .continuous)
                            .frame(maxWidth: width, maxHeight: height)
                            .foregroundColor(colorScheme == .light ? .gray.opacity(0.3) : .gray.opacity(0.3))
                        RoundedRectangle(cornerRadius: height, style: .continuous)
                            .frame(maxWidth: percent * multiplier, maxHeight: height)

                            .background(LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                                .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                            )
                            .foregroundColor(.clear)
                    }
                    .padding([.horizontal], 16)

                    Button("DONATE") {
                        // Show Dono Page
                    }
                    .background(colorScheme == .light ? .red : .gray.opacity(0.3))
                    .foregroundColor(.white)
                    .buttonStyle(.bordered)
                    .font(.subheadline)
                    .bold()
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                }.frame(height: 130)
            }
            .frame(height: 130)

//        case .video(let id):
//            let avPlayer = AVPlayer(url:  Bundle.main.url(forResource: id, withExtension: "mov")!)
//            GeometryReader { proxy in
//                VideoPlayer(player: avPlayer)
//                    .frame(width: 450, height: 900, alignment: .center)
//                    .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
//                    .scaledToFill()
//                    .clipped()
//                    .onAppear() {
//                        avPlayer.isMuted = true
//                        avPlayer.play()
//                        avPlayer.volume = 0
//                    }
//                    .onDisappear {
//                        avPlayer.isMuted = true
//                        avPlayer.pause()
//                        avPlayer.volume = 0
//                    }
//            }
//            .frame(height: 200)
//            .clipped()
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//            .shadow(radius: colorScheme == .light ? 1 : 0)
//            .zIndex(-100)
        case .video(_):
            Rectangle()
        }
    }
}

#Preview {
    ActivityFeedView()
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

    var ngoSelected: ((CompanyObject) -> Void)

    var actvityPostSelected: ((ActvityPost) -> Void)

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
                                    .onTapGesture { ngoSelected(activityPost.company) }
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
                                            ngoSelected(activityPost.company)
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


                                if let media = activityPost.media {
                                    MediaView(media: media)
                                        .padding([.vertical], 8)
                                        .frame(width: 200, height: 200)
                                        .onTapGesture {
                                            actvityPostSelected(activityPost)
                                        }

                                }
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
