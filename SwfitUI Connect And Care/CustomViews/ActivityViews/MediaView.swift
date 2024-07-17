import Foundation
import SwiftUI

struct MediaView: View {

    struct Constants {
        static let MediaViewCornerRadius: CGFloat = 8
        static let MediaViewFrameHeight: CGFloat = 200
    }

    let media: ActvityPost.Media
    @Environment (\.colorScheme) var colorScheme

    var body: some View {
        viewForMedia(media)
    }

    @ViewBuilder
    func viewForMedia(_ media: ActvityPost.Media) -> some View {

        switch media {
        case .photo(let photo):
            photo.image
                .resizable()
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
                        ForEach(images) { imageData in
                            imageData.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: proxySize.width,
                                       height: proxySize.height,
                                       alignment: .center
                                )
                                .clipShape(RoundedRectangle(cornerRadius: Constants.MediaViewCornerRadius))
                                .shadow(radius: colorScheme == .light ? 1 : 0)
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
        }
    }
}

#Preview {
    ActivityFeedView(viewModel: BasicFakeActivityFeed())
}
