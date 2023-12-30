//
//  ActivityFeedView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI

struct ActivityFeedView: View {

    let activityPost = ActvityPost.makeFakeActivityPosts()

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading) {
                    ForEach(activityPost) { activityPost in
                        HStack(alignment: .top, spacing: 12) {
                            activityPost.comapany.logo
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 6) {
                                    HStack(spacing: 0) {
                                        Text(activityPost.comapany.orginizationName)
                                            .font(.subheadline)
                                            .bold()
                                        Text(" • 11h")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Image(systemName: "ellipsis")
                                    }

                                if let caption = activityPost.caption {
                                    Text(caption).font(.subheadline)
                                }

                                if let media = activityPost.media {
                                    MediaView(media: media)
                                        .padding([.vertical], 8)
                                }
                            }
                        }
                        Divider()
                    }
                    .padding([.horizontal], 16)
                    .padding([.vertical], 8)
                }
            }
            .scrollClipDisabled()
            .navigationTitle("Updates")
            .contentMargins([.top], 32)
            .toolbar {
                Image(systemName: "line.3.horizontal.decrease.circle")

//                Menu {
//                    Button {
//                        // action for menu item 1
//                    } label: {
//                        Label("Menu Item 1", systemImage: "icon_name")
//                    }
//                    // Additional menu items
//                } label: {
//                    Label("Menu Button", systemImage: "icon_name")
//                }

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
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding([.trailing], 8)
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
                        }
                    }.scrollTargetLayout()

                }.scrollClipDisabled()
                    .scrollTargetBehavior(.viewAligned)
            }.frame(height: 250)
        case .donation:
            Text("f")
        case .donationProgress(_):
            GeometryReader { proxy in
                var width: CGFloat = proxy.frame(in: .local).width
                var height: CGFloat = 20
                var percent: CGFloat = 69
                var color1 = Color(Color.orange)
                var color2 = Color(Color.pink)

                let multiplier = width / 100

                VStack(alignment: .center) {
                    HStack {
                        Text("$957")
                            .font(.largeTitle)

                        Text("/ $1000")
                            .font(.largeTitle)
                            .opacity(0.5)
                    }

                    ZStack(alignment: .leading) {
                        //                        RoundedRectangle(cornerRadius: height, style: .continuous)
                        //                            .frame(width: width, height: height)
                        //                            .foregroundColor(colorScheme == .light ? .gray.opacity(0.3) : .gray.opacity(0.3))
                        //                        RoundedRectangle(cornerRadius: height, style: .continuous)
                        //                            .frame(width: percent * multiplier, height: height)
                        //
                        //                            .background(LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                        //                                .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                        //                            )
                        //                            .foregroundColor(.clear)

                        RoundedRectangle(cornerRadius: height, style: .continuous)
                            .frame(maxWidth: width, maxHeight: height)
                            .foregroundColor(colorScheme == .light ? .gray.opacity(0.3) : .gray.opacity(0.3))
                        RoundedRectangle(cornerRadius: height, style: .continuous)
                            .frame(maxWidth: percent * multiplier, maxHeight: height)

                            .background(LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                                .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                            )
                            .foregroundColor(.clear)
                    }.padding([.horizontal], 16)

                    //                .border(Color.red)

                    Spacer()

                    Text("SHOW SUPPORT")
//                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .padding([.vertical], 6)
                        .padding([.horizontal], 8)
                        .foregroundColor(.white)
                        .background(.regularMaterial.opacity(0.1))
                        .background(Color(red: 255/255, green: 75/255, blue: 96/255))
                        .environment(\.colorScheme, .dark)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
                        )
                        .onTapGesture {

                        }
                }
            }
            .frame(height: 150)
        }
    }
}

#Preview {
    ActivityFeedView()
}

struct ActvityPost: Hashable, Identifiable {
    static func == (lhs: ActvityPost, rhs: ActvityPost) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    typealias Percentage = Double

    enum Media {
        case photo(IdentifiableImage)
        case photos([IdentifiableImage])
        case donation
        case donationProgress(Percentage)
    }

    let id = UUID()
    let comapany: CompanyObject
    let caption: String?
    let media: Media?

    static func makeFakeActivityPosts() -> [ActvityPost] {

        return [
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: nil
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage()))
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: nil
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: nil
            ),

            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "We're $200 away from our fundrasing goal! Thank you all for the support! ",
                media:.donationProgress(94)
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: .photos(
                    [
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                    ]
                )
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: nil
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage()))
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: nil
            ),

            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "We're $200 away from our fundrasing goal! Thank you all for the support! ",
                media:.donationProgress(94)
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: .photos(
                    [
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                        IdentifiableImage(image: CompanyObject.generateRadomImage()),
                    ]
                )
            ),
            ActvityPost(
                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
                caption: "SO so happy to start working on our new projects!",
                media: nil
            ),
//            ActvityPost(
//                comapany: company,
//                caption: "We're ",
//                media: .donation
//            ),
//            ActvityPost(
//                comapany: CompanyObject.ceateFakeComapnyList().randomElement()!,
//                caption: "We're $200 away from our fundrasing goal! Thank you all for the support! ",
//                media:.donationProgress(94)
//            )
        ]
    }
}

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: Image
}
