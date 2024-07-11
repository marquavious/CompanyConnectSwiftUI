//
//  ViewModifiers.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/21/23.
//

import Foundation
import SwiftUI

enum PrimaryColors {
    case primary

    var color: Color {
        switch self {
        case .primary:
            return Color(red: 28/255, green: 68/255, blue: 108/255)
        }
    }
}

struct WhiteButtonViewModifiers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight:47)
            .background(Color.white)
            .fontWeight(.semibold)
            .cornerRadius(3.0)
    }
}
