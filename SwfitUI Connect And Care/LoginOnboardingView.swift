//
//  LoginOnboardingView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/19/23.
//

import SwiftUI

struct LoginOnboardingView: View {
    var body: some View {
        ZStack {
            Color(red: 28/255, green: 68/255, blue: 108/255)
                .ignoresSafeArea()
            VStack() {
                TabView {
                    ForEach(0...4, id: \.self) { _ in
                        VStack(spacing: 20) {
                            Rectangle()
                                .fill(Color.red)
                                .clipped()
                                .frame(maxWidth:150, maxHeight: 150)
                            Group {
                                Text("Welcome!")
                                    .modifier(OnboardingTitleTextViewModifier())
                                Text("Welcome to Connect & Care: Let's change philanthropy together")
                                    .modifier(OnboardingSubTitleTextViewModifier())
                            }
                            .multilineTextAlignment(.center)
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .ignoresSafeArea()

                VStack {
                    Button("Continue with Facebook") { }
                        .frame(maxWidth: .infinity, minHeight:47)
                        .background(Color.white)
                        .foregroundColor(Color(red: 22/255, green: 51/255, blue: 89/255))
                        .fontWeight(.semibold)
                        .cornerRadius(3.0)
                    Button("Continue with Email") { }
                        .frame(maxWidth: .infinity, minHeight:47)
                        .background(Color.white.opacity(0.08))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .cornerRadius(3.0)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
            }
        }
    }
}

#Preview {
    LoginOnboardingView()
}
