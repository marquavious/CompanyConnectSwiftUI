//
//  ButtonViewModifiers.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/20/23.
//

import Foundation
import SwiftUI

struct WhiteButtonViewModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight:47)
            .background(Color.white)
            .foregroundColor(Color(red: 28/255, green: 68/255, blue: 108/255))
            .fontWeight(.semibold)
            .cornerRadius(3.0)
    }
}

struct PrimaryColorButtonViewModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight:47)
            .background(Color.white.opacity(0.08))
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .cornerRadius(3.0)
    }
}
