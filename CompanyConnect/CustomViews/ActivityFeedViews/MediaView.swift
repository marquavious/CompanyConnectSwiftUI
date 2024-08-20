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
    private func createImageView(photoUrl: String) -> some View {
        AsyncImage(url: URL(string: photoUrl)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            Color.gray
        }
        .clipShape(RoundedRectangle(cornerRadius: Constants.MediaViewCornerRadius))
        .shadow(radius: colorScheme == .light ? 1 : 0)
    }

    @ViewBuilder
    func viewForMedia(_ media: Media) -> some View {
        switch media {
        case .photo(let photoUrl):
            createImageView(photoUrl: photoUrl)
                .frame(height: Constants.MediaViewFrameHeight)

        case .photoCarousel(let imageData):
            let imageData = imageData.sorted { dataOne, dataTwo in
                dataOne.index < dataTwo.index
            }

            GeometryReader { proxy in
                let proxySize = proxy.frame(in: .local)
                let rows = [GridItem(.flexible())]

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows) {
                        ForEach(imageData, id: \.self) { imageData in
                            createImageView(photoUrl: imageData.imageUrl)
                                .frame(width: proxySize.width,
                                       height: proxySize.height,
                                       alignment: .center)
                        }
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
    ActivityFeedTabView()
}

