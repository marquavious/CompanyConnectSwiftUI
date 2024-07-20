//
//  ActivityViewCell.swift
//  SwfitUI Connect And Care
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
    let posterSelected: () -> Void
    let visitProfileTapped: () -> Void
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: Constants.ActivityCellPhotoContentPadding) {
                if let poster = activityPost.poster {
                    poster.image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: Constants.ActivityCellProfilePictureSize.width,
                            height: Constants.ActivityCellProfilePictureSize.height
                        )
                        .clipShape(Circle())
                        .overlay(alignment: .bottomTrailing) {
                            LogoImageView(
                                logoImageViewData: activityPost.company.logoImageData,
                                size: Constants.ActivityCellProfilePictureBadgeSize,
                                overrideLogoWithFontSize: .caption2
                            )
                            .offset(x: 8, y: 8)
                        }
                        .onTapGesture { posterSelected() }
                } else {
                    LogoImageView(
                        logoImageViewData: activityPost.company.logoImageData,
                        size: Constants.ActivityCellProfilePictureSize
                    )
                    .onTapGesture { posterSelected() }
                }

                VStack(alignment: .leading, spacing: Constants.ActivityCellInternalContentPadding) {
                    HStack(spacing: .zero) {
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
                            .onTapGesture { posterSelected() }

                        Text(" • \(activityPost.hourAgoPosted)h")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Spacer()

                        Menu {
                            Button("Share", systemImage: Icons.ShareIcon.rawValue) {
                                // - TODO: IMPLIMENT SHARE
                            }
                            Button("Visit Profile", systemImage: Icons.VisitProfile.rawValue) {
                                // - TODO: IMPLIMENT PROFILE VISIT FLOW
                                visitProfileTapped()
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
                            .padding([.vertical], Constants.ActivityCellMedaiViewBottomPadding)
                    }
                }
            }
            .padding([.top], Constants.ActivityCellContentTopPadding)
            .padding([.horizontal], Constants.ActivityCellContentHorizontalPadding)
        }
    }
}

#Preview {
    ActivityFeedView(viewModel: BasicFakeActivityFeed())
}
