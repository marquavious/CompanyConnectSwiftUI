//
//  MediaView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/16/24.
//

import Foundation
import SwiftUI

struct MediaView: View {

    struct Constants {
        static let MediaViewCornerRadius: CGFloat = 8
        static let MediaViewFrameHeight: CGFloat = 200
        static let DonationProgessViewTrailingPadding: CGFloat = 16
    }

    @Environment (\.colorScheme) var colorScheme

    let media: Media

    var body: some View {
        viewForMedia(media)
    }

    @ViewBuilder
    func viewForMedia(_ media: Media) -> some View {
        switch media {
        case .photo(let photo):
            AsyncImage(url: URL(string: photo)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: Constants.MediaViewFrameHeight)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.MediaViewCornerRadius))
                    .shadow(radius: colorScheme == .light ? 1 : 0)
            } placeholder: {
                Color.gray
            }
            .frame(
                height:  Constants.MediaViewFrameHeight
            )
            .scaledToFill()
            .frame(height: Constants.MediaViewFrameHeight)
            .clipShape(RoundedRectangle(cornerRadius: Constants.MediaViewCornerRadius))
            .shadow(radius: colorScheme == .light ? 1 : 0)

        case .photoCarousel(let images):

            GeometryReader { proxy in
                let proxySize = proxy.frame(in: .local)
                let rows = [GridItem(.flexible())]

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows) {
                        ForEach(images, id: \.self) { imageData in
                            AsyncImage(url: URL(string: imageData)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: proxySize.width,
                                             height: proxySize.height,
                                             alignment: .center
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: Constants.MediaViewCornerRadius))
                                    .shadow(radius: colorScheme == .light ? 1 : 0)
                                    .scrollTargetLayout()
                            } placeholder: {
                                Color.gray
                                    .frame(width: proxySize.width,
                                         height: proxySize.height,
                                         alignment: .center
                                )
                                .clipShape(RoundedRectangle(cornerRadius: Constants.MediaViewCornerRadius))
                                .shadow(radius: colorScheme == .light ? 1 : 0)
                                .scrollTargetLayout()
                            }
                            .frame(
                                height:  Constants.MediaViewFrameHeight
                            )
                            .frame(width: proxySize.width,
                                     height: proxySize.height,
                                     alignment: .center
                            )
                            .clipShape(RoundedRectangle(cornerRadius: Constants.MediaViewCornerRadius))
                            .shadow(radius: colorScheme == .light ? 1 : 0)
                            .scrollTargetLayout()
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetLayout()


                }
                .scrollClipDisabled()
                .scrollTargetBehavior(.viewAligned)
            }
            .frame(height: Constants.MediaViewFrameHeight)

        case .donationProgress(let donationProgress, let donationTotal):

            DonationProgessView(
                donationProgress: donationProgress,
                donationTotal: donationTotal
            )
            .padding(.trailing, Constants.DonationProgessViewTrailingPadding)
        }
    }

}

#Preview {
    ActivityFeedTabView(viewModel: DevHomeTabActivityFeed())
}
