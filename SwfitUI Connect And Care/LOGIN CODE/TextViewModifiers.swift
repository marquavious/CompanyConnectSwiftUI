//
//  TextViewModifiers.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/20/23.
//

import Foundation
import SwiftUI

struct OnboardingTitleTextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.white)
            .fontWeight(.semibold)
            .font(.system(size: 26))
    }
}

struct OnboardingSubTitleTextViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.white)
    }
}
