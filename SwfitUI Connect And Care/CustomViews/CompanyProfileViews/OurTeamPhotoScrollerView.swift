//
//  OurTeamPhotoScrollerView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct OurTeamPhotoScrollerView: View {
    var companyObject: CompanyObject
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem()]) {
                ForEach(companyObject.team, id: \.id) { member in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.background)
                        VStack {
                            member.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 85, height: 85)
                                .clipShape(Circle())

                            VStack(alignment: .center) {
                                Text(member.name)
                                    .font(.subheadline)
                                    .bold()
                                Text(member.position)
                                    .font(.caption)
                                    .italic()
                                    .foregroundColor(.gray)
                            }
                            .padding(8)
                        }
                    }
                    .frame(minWidth: 12, maxHeight: 175)
                    .frame(width: 90)
                    .padding([.bottom, .trailing, .top], 8)
                }
            }
        }
        .contentMargins(.horizontal, 16)
    }
}
