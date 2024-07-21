//
//  CompanyProfileTextView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

enum MediaLocation {
    case top, middle, bottom, none
}

struct CompanyProfileTextView<Content: View>: View {

    init(
        titleText: String,
        text: String? = nil,
        mediaLocation: MediaLocation = .none,
        @ViewBuilder viewBuilder: @escaping () -> Content? = { nil }) {

            self.titleText = titleText
            self.text = text
            self.mediaLocation = mediaLocation
            self.viewBuilder = viewBuilder
        }

    let titleText: String
    let text: String?
    let mediaLocation: MediaLocation
    let viewBuilder: () -> Content?

    var body: some View {

        VStack(alignment: .leading) {

            if mediaLocation == .top { viewBuilder() }

            Text(titleText)
                .font(.title2)
                .multilineTextAlignment(.leading)
                .bold()
                .padding([.top, .bottom], 8)
                .padding([.leading, .trailing])

            if mediaLocation == .middle { viewBuilder() }

            if let text = text {
                Text(text)
                    .font(.subheadline)
                    .padding([.leading, .trailing, .bottom])
            }

            if mediaLocation == .bottom { viewBuilder() }
        }
        .background()
    }

}

#Preview {
    CompanyProfileView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
