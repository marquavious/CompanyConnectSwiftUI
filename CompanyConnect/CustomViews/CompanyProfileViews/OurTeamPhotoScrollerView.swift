//
//  OurTeamPhotoScrollerView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct OurTeamPhotoScrollerView: View {

    struct Constants {
        static let ProfilePictureSize: CGSize = CGSize(width: 85, height: 85)
        static let MemberInfoPadding: CGFloat = 8
        static let HorizonalContentPadding: CGFloat = 16
        static let CellSize: CGSize = CGSize(width: 90, height: 160)
        static let CellPadding: CGFloat = 4
    }

    let teamMembers: [TeamMember]
    private let rows = [GridItem()]

    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            LazyHGrid(rows: rows) {
                ForEach(teamMembers, id: \.name) { member in
                    VStack {
                        AsyncImage(url: URL(string: member.imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(
                            width: Constants.ProfilePictureSize.width,
                            height: Constants.ProfilePictureSize.height
                        )
                        .clipShape(Circle())

                        VStack(alignment: .center) {
                            Text(member.name)
                                .font(.subheadline)
                                .bold()
                            Text(member.position)
                                .lineLimit(1)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .italic()
                                .foregroundColor(.gray)
                        }
                        .padding(Constants.MemberInfoPadding)
                    }
                    .frame(
                        width: Constants.CellSize.width,
                        height:  Constants.CellSize.height
                    )
                    .padding(Constants.CellPadding)
                }
            }
        }
        .contentMargins(.horizontal, Constants.HorizonalContentPadding)
    }

}

#Preview {
    OurTeamPhotoScrollerView(teamMembers: TeamMember.generateRandomTeamList())
}
