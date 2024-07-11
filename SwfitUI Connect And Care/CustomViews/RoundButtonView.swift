//
//  RoundButtonView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct RoundButtonView: View {
    let text: String
    let color: Color

    @Environment(\.colorScheme) var colorScheme

    var onTapAction: ((Bool) -> Void)?

    var isHighlighted: Bool = true

    var body: some View {
        ZStack {
            colorScheme == .light ? (isHighlighted ? color : Color.white) :
            (isHighlighted ? color : Color.clear)

            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding([.leading, .trailing], 16)
                .foregroundColor(
                    colorScheme == .light ? (isHighlighted ? .white : Color.black.opacity(0.7)) : .white
                )
        }.onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                onTapAction?(isHighlighted)
            }
        }
        .background(colorScheme == .light ? Color.clear : .gray.opacity(0.3))
        .cornerRadius(8)
        .shadow(radius: colorScheme == .light ? 1 : 0)
    }
}

extension RoundButtonView {
    func onTap(_ handler: @escaping (Bool) -> Void) -> RoundButtonView {
        var new = self
        new.onTapAction = handler
        return new
    }
}
