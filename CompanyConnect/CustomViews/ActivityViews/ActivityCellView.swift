//
//  ActivityViewCell.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/16/24.
//

import Foundation
import SwiftUI

struct ActivityCellView: View {

    struct Constants {
        static let ActivityCellProfilePictureSize: CGSize = CGSize(width: 40, height: 40)
        static let ActivityCellProfilePictureBadgeSize: CGSize = CGSize(width: 20, height: 20)
        static let ActivityCellPhotoContentPadding: CGFloat = 12
        static let ActivityCellContentTopPadding: CGFloat = 8
        static let ActivityCellContentHorizontalPadding: CGFloat = 16
        static let ActivityCellMediaViewMaxHeight: CGFloat = 200
        static let ActivityCellInternalContentPadding: CGFloat = 6
        static let ActivityCellCaptionBottomPadding: CGFloat = 8
        static let ActivityCellMedaiViewBottomPadding: CGFloat = 8
    }

    enum Icons: String {
        case ShareIcon = "square.and.arrow.up"
        case ActionButton = "ellipsis"
        case VisitProfile = "person.crop.circle"
    }

    let activityPost: ActvityPost
    let companySelected: (() -> Void)?

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: Constants.ActivityCellPhotoContentPadding) {
                if let posterData = activityPost.poster {
                    AsyncImage(url: URL(string: posterData.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(
                        width: Constants.ActivityCellProfilePictureSize.width,
                        height: Constants.ActivityCellProfilePictureSize.height
                    )
                    .clipShape(Circle())
                    .overlay(alignment: .bottomTrailing) {
                        AsyncImage(url: URL(string: activityPost.company.logoUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()

                        } placeholder: {
                            Color.gray
                        }
                        .frame(
                            width: Constants.ActivityCellProfilePictureBadgeSize.width,
                            height: Constants.ActivityCellProfilePictureBadgeSize.height
                        )
                        .clipShape(Circle())
                        .overlay(Circle().stroke(.background, lineWidth: 1))
                        .offset(x: 5, y: 5)
                    }
                    .onTapGesture { companySelected?() }
                } else {
                    AsyncImage(url: URL(string: activityPost.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()

                    } placeholder: {
                        Color.gray
                    }
                    .frame(
                        width: Constants.ActivityCellProfilePictureSize.width,
                        height: Constants.ActivityCellProfilePictureSize.height
                    )
                    .clipShape(Circle())
                    .onTapGesture { companySelected?() }
                }

                VStack(alignment: .leading, spacing: Constants.ActivityCellInternalContentPadding) {
                    HStack(spacing: .zero) {
                        if let posterData = activityPost.poster {
                            Text("\(posterData.name)")
                                .font(.subheadline)
                                .bold()

                            Text(" from ")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Text(activityPost.company.name)
                            .font(.subheadline)
                            .bold()
                            .onTapGesture { companySelected?() }

                        Text(" • \(Date.timeAgo(for: activityPost.date))")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Spacer()

                        Menu {
                            Button("Share", systemImage: Icons.ShareIcon.rawValue) {
                                // - TODO: IMPLIMENT SHARE
                            }
                            Button("Visit Profile", systemImage: Icons.VisitProfile.rawValue) {
                                companySelected?()
                            }
                        } label: {
                            Label(String(), systemImage: Icons.ActionButton.rawValue)
                                .tint(colorScheme == .light ? .black:.white)
                        }
                    }

                    if let caption = activityPost.caption {
                        Text(caption)
                            .font(.system(size: 14))
                            .padding([.bottom], Constants.ActivityCellCaptionBottomPadding)
                    }

                    if let media = activityPost.media {
                        MediaView(media: media)
                            .frame(maxHeight: Constants.ActivityCellMediaViewMaxHeight)
                            .padding([.bottom], Constants.ActivityCellMedaiViewBottomPadding)
                    }
                    
                }
            }
            .padding([.top], Constants.ActivityCellContentTopPadding)
            .padding([.horizontal], Constants.ActivityCellContentHorizontalPadding)

        }
        .background(.background)
    }
}

#Preview {
    ActivityFeedTabView(coordinator: DevNavigationCoordinator(), viewModel: DevHomeTabActivityFeed())
}
