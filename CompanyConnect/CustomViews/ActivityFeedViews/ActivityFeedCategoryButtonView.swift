//
//  RoundButtonView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct ActivityFeedCategoryButtonView: View {

    struct Constants {
        static let Padding: CGFloat = 16
    }

    @Environment(\.colorScheme) var colorScheme

    let text: String
    let color: Color
    var isHighlighted: Bool
    var onTapAction: (() -> Void)

    var body: some View {
        ZStack {
            colorScheme == .light ? (isHighlighted ? color : .white) : (isHighlighted ? color : .clear)

            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(
                    [.leading, .trailing],
                    Constants.Padding
                )
                .foregroundColor(
                    colorScheme == .light ? (isHighlighted ? .white : Color.black.opacity(0.7)) : .white
                )
        }
        .background(colorScheme == .light ? Color.clear : .gray.opacity(0.3))
        .cornerRadius(8)
        .shadow(radius: colorScheme == .light ? 1 : 0)
        .onTapGesture {
            onTapAction()
        }
    }
}

#Preview {
    ActivityFeedTabView()
}
