//
//  ContentView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 28/255, green: 68/255, blue: 108/255)
                .ignoresSafeArea()
            VStack() {
                TabView {
                    ForEach(0...4, id: \.self) { _ in
                        VStack(spacing: 20) {
                            Spacer()
                            Rectangle()
                                .fill(Color.red)
                                .clipped()
                                .frame(maxWidth:150, maxHeight: 150)
                            Text("Welcome!")
                                .foregroundStyle(Color.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 26))
                            Text("Welcome to Connect & Care: Let's change philanthropy together")
                                .foregroundStyle(Color.white)
//                            Spacer()

                        }
//                        .frame(maxHeight: .infinity, alignment: .bottom)
                        /*
                        Rectangle()
                            .fill(Color.red)
                            .clipped()
                         */
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
    ContentView()
}

//Text("Welcome!")
//Text("Welcome to Connect & Care: Let's change philanthropy together")


/*
ZStack {
    Color(red: 28/255, green: 68/255, blue: 108/255)
        .ignoresSafeArea()
    VStack {
        ScrollView([.horizontal], showsIndicators: true) {
            VStack() {
                HStack(spacing: 0) {
                    ForEach(0...4, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: UIScreen.main.bounds.width, height: .infinity)
                            .clipped()
                    }
                }
            }
        }
        .scrollTargetBehavior(.paging)

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
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16))
    }
}
*/
