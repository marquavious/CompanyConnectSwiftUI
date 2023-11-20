//
//  UserInputView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/20/23.
//

import SwiftUI

struct UserInputView: View {
    @State var userEmail = ""

    var body: some View {
        ZStack {
            Color(red: 28/255, green: 68/255, blue: 108/255)
                .ignoresSafeArea()
            VStack(spacing: 13) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100) 
                Group {
                    Text("Welcome to Connect & Care! ")
                        .modifier(OnboardingTitleTextViewModifier())
                    Text("Join the Community! Enter your email address below to get started.")
                        .modifier(OnboardingSubTitleTextViewModifier())
                }
                .multilineTextAlignment(.center)

                ZStack {
                    Rectangle()
                        .fill(Color.white.opacity(0.08))
                        .cornerRadius(3.0)
                    TextField("Email Address", text: $userEmail)
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                }
                .frame(height: 47)
                

                Button("Contiune") { }
                    .modifier(WhiteButtonViewModifiers())
                Group {
                    Text("Wait,").foregroundColor(Color(red: 170/255, green: 170/255, blue: 170/255)) +
                    Text(" why do we need your email?")
                        .foregroundStyle(Color.white)
                        .bold()
                }.font(Font.caption2)
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
    }
}

#Preview {
    UserInputView()
}
