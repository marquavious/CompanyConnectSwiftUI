//
//  TextFieldViewModifiers.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/21/23.
//

import SwiftUI

struct BasicInputTextViewViewModifier: ViewModifier {

    public func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.white.opacity(0.08))
                .cornerRadius(3.0)
            //            TextField("",
//            /* text: $ema*/ilTextField,
            content
                //.prompt(Text("Email").foregroundColor(Color.white.opacity(0.25)))
                .foregroundColor(Color.white)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .tint(Color.white)
//            .modifier(TextViewClearButtonViewModifier(text: $emailTextField))
        }
        .frame(height: 47)}
}

struct TextViewClearButtonViewModifier: ViewModifier {
    @Binding var text: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content

            if !text.isEmpty {
                Button() {
                    self.text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(Color.white.opacity(0.25)))
                }
                .padding(.trailing, 8)
            }
        }
    }
}
