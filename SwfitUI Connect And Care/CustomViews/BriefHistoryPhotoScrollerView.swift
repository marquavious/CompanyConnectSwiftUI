//
//  BriefHistoryPhotoScrollerView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct BriefHistoryPhotoScrollerView: View {
    var companyObject: CompanyObject
    var body: some View {
        VStack(alignment: .center) {
            TabView {
                ForEach(companyObject.briefHistoryObject.imageObjects, id: \.self) { object in
                    VStack {
                        Rectangle()
                            .fill(.background)
                            .overlay {
                                VStack {
                                    object.image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 200, alignment: .bottom)

                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding([.leading, .trailing])
                                    Spacer()

                                    Text(object.caption)
                                        .font(.callout.italic())
                                        .padding(8)
                                }
                            }
                        Spacer(minLength: 40)
                    }
                }
            }
            .frame(minHeight: 300, alignment: .top)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
    }
}
