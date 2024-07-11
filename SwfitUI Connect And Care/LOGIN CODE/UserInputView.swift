//
//  UserInputView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/20/23.
//

import SwiftUI

protocol UserInputViewDelegate: AnyObject {
    func userDidPressActionButton(view: UserInputView, inputText: String)
}

struct UserInputView: View {

    @State var title: String
    @State var subtitle: String
    @State var userInputText: String = ""
    @State var userTextfieldPromt: String
    @State var actionButtonText: String
    @State var isLoading: Bool = false

    weak var delegate: UserInputViewDelegate?

    var body: some View {
        ZStack {
            Color(red: 28/255, green: 68/255, blue: 108/255)
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard()
                }
            VStack(spacing: 13) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white.gradient)
                    .frame(width: 114, height: 114)
                Group {
                    Text(title)
                        .modifier(OnboardingTitleTextViewModifier())
                    Text(subtitle)
                        .modifier(OnboardingSubTitleTextViewModifier())
                }
                .multilineTextAlignment(.center)

                Spacer()
                    .frame(height:8)

                ZStack {
                    Rectangle()
                        .fill(Color.white.opacity(0.08))
                        .cornerRadius(3.0)
                    TextField("User Input", text: $userInputText, prompt: Text(userTextfieldPromt).foregroundColor(Color.white.opacity(0.25)))
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .tint(Color.white)
                        .autocapitalization(.none)
                        .modifier(TextViewClearButtonViewModifier(text: $userInputText))
                }
                .frame(height: 47)

                ZStack(alignment: .trailing) {
                    Button(actionButtonText) {
                        isLoading.toggle()
                        delegate?.userDidPressActionButton(view: self, inputText: userInputText)
                    }
                    .modifier(WhiteButtonViewModifiers())
                    .allowsHitTesting(!userInputText.isEmpty ? true : false)
                    .foregroundColor(!userInputText.isEmpty ?
                                     Color(red: 28/255, green: 68/255, blue: 108/255):
                                        Color(red: 28/255, green: 68/255, blue: 108/255).opacity(0.5)
                    )

                    if isLoading {
                        ProgressView()
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                    }

                }
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
    }
}


#Preview {
    UserInputView(
        title: "Welcome to Connect & Care!",
        subtitle: "Join the Community! Enter your email address below to get started.",
        userTextfieldPromt: "Email",
        actionButtonText: "Continue"
    )
}
