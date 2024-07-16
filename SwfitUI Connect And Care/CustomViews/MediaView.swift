import Foundation
import SwiftUI

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
        }
    }
}
