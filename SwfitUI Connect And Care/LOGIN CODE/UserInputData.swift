//
//  UserInputData.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/22/23.
//

// TODO: - Clean up

import Foundation
import SwiftUI

/*
struct UserInputViewControllerInfo {
    let image: Image
    let title: String
    let subtitle: String
    let actionButtonText: String
    let userInputTextField: UserInputTextField
    // Eventually add disclaimers
}

class UserInputViewControllerViewModel: ObservableObject {
    @Published var userInputViewObject: UserInputViewObjectViewModel

    init() {
        self.userInputViewObject = UserInputViewObject(
            image: Image("person.badge.key"),
            title: "This is a smaple User Input Title",
            subtitle: "Below, you should see all of your custom Input Fields",
            actionButtonText: "Action Button Text",
            userInputTextFields: UserInputTextField(prompt: "Test Input", type: .generic)
        )
    }
}

 struct UserInputTextField: Hashable {
     let prompt: String
     let type: UserInputTextType
 }

 enum UserInputTextType {
     case name, email, phoneNumber, generic
 }
*/

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

