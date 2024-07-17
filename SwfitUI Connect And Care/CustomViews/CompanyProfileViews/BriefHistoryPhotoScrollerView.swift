//
//  BriefHistoryPhotoScrollerView.swift
//  SwfitUI Connect And Care
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

    let companyObject: CompanyObject

    var body: some View {
        TabView {
            ForEach(companyObject.briefHistoryObject.imageObjects) { object in
                VStack {
                    object.image
                        .resizable()
                        .scaledToFill()
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
    NGOProfileView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
