//
//  StretchyHeaderURLView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation
import SwiftUI

struct StretchyHeaderURLView: View {

    @State var headerViewHeight: CGFloat
    @State var url: String

    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -proxy.frame(in: .global).minY)
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: max(proxy.frame(in: .global).minY + headerViewHeight, 0)
                    )

            } placeholder: {
                Color.gray
                    .offset(y: -proxy.frame(in: .global).minY)
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: max(proxy.frame(in: .global).minY + headerViewHeight, 0)
                    )
            }
        }
        .frame(height: headerViewHeight)
        .ignoresSafeArea()
    }
}

#Preview {
    CompanyProfileView(companyObject: Company.createFakeCompanyObject())
}
