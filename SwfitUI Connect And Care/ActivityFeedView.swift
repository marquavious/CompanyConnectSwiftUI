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
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading) {
                ForEach(activityPost) { post in
                    HStack(alignment: .top) {
                        post.comapany.logo
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text(post.comapany.orginizationName)
                                .bold()
                            if let caption = post.caption {
                                Text(caption)
                            }

                            if let media = post.media {
                                MediaView(media: media)
                                    .border(Color.yellow)
                            }

                        }
                        .border(Color.red)
                        Divider()
                    }
                }
            }
        }.background(Color.blue)
    }
}

struct MediaView: View {
    let media: ActvityPost.Media
    var body: some View {
        switch media {
        case .photo(let photo):
            photo.image
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 8))
        case .photos(let images):
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())]) {
                    ForEach(images, id: \.id) { image in
                        image.image
                            .resizable()
                            .scaledToFill()
                            .frame(minHeight: 800)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }.scrollTargetLayout()
                }
            }.scrollTargetBehavior(.paging)
        case .donation:
            Text("f")
        case .donationProgress(let progress):
            Text("f")
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

        let company = CompanyObject.ceateFakeComapnyList().first!

        return [
            ActvityPost(
                comapany: company,
                caption: "SO so happy to start working on our new projects!",
                media: nil
            ),
            ActvityPost(
                comapany: company,
                caption: "SO so happy to start working on our new projects!",
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage()))
            ),
            ActvityPost(
                comapany: company,
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
                comapany: company,
                caption: "SO so happy to start working on our new projects!",
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage()))
            ),
            ActvityPost(
                comapany: company,
                caption: "SO so happy to start working on our new projects!",
                media: .photo(IdentifiableImage(image: CompanyObject.generateRadomImage()))
            )
        ]
    }
}

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: Image
}
