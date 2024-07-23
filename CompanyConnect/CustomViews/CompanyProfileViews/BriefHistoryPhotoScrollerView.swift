//
//  BriefHistoryPhotoScrollerView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct BriefHistoryPhotoScrollerView: View {

    struct Constants {
        static let ImageHeight: CGFloat = 200
        static let TabViewHeight: CGFloat = 300
        static let CaptionPadding: CGFloat = 8
    }

    let briefHistoryObject: BriefHistoryObject

    var body: some View {
        TabView {
            ForEach(briefHistoryObject.imageObjects, id: \.imageUrl) { object in
                VStack {
                    AsyncImage(url: URL(string: object.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(
                        height: Constants.ImageHeight,
                        alignment: .center
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding([.leading, .trailing])

                    Text(object.caption)
                        .font(.callout.italic())
                        .padding(Constants.CaptionPadding)
                    Spacer()
                }
            }
        }
        .frame(
            minHeight: Constants.TabViewHeight,
            alignment: .top
        )
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }

}

#Preview {
    BriefHistoryPhotoScrollerView(briefHistoryObject: BriefHistoryObject.createFakeBriefHistoryObject())
}
