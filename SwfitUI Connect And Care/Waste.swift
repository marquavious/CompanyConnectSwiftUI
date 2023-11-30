//
//  Waste.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/22/23.
//

import SwiftUI
/*
struct TestView: View {
    let rows = [
        GridItem(.flexible())
    ]
    @State var selectedItem: Int?

    let info = ["a","b","c","d","e","f"]

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows) {
                    ForEach(info, id: \.self) { infor in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red)
                            .frame(width: 150, height: 100)
                            .onTapGesture {
                                print(infor)
                            }
                    }
                }.scrollTargetLayout()
            }
            .background(Color.blue)
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
 */

struct TestView: View {
    let colors: [Color] = [.red, .green, .blue]

    var body: some View {
        ScrollViewReader { value in

            Button("Jump to #8") {
                value.scrollTo(8, anchor: .top)
            }

            ScrollView {

//                .padding()

                ForEach(0..<100) { i in
                    Text("Example \(i)")
                        .font(.title)
                        .frame(width: 200, height: 200)
                        .background(colors[i % colors.count])
                        .id(i)
                }
            }
        }
//        .frame(height: 350)
    }
}


#Preview {
    TestView()
}

//
//struct UserInputTextView: View {
//
//    var body: some View {
//
//    }
//}

//struct UserInputTextView: View {
//    let prompt: String
//    @State var userInput = ""
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color.white.opacity(0.08))
//                .cornerRadius(3.0)
//            TextField("", text: $userInput, prompt: Text("\(prompt)").foregroundColor(Color.white.opacity(0.25)))
//                .foregroundColor(Color.white)
//                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
//                .keyboardType(.emailAddress)
//                .autocorrectionDisabled()
//                .tint(Color.white)
//        }
//        .frame(height: 47)
//    }
//}


//Group {
//    Text("Wait,").foregroundColor(Color(red: 170/255, green: 170/255, blue: 170/255)) +
//    Text(" why do we need your email?")
//        .foregroundStyle(Color.white)
//        .bold()
//}.font(Font.caption2)


//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: 100, height: 100)
//                Group {
//                    Text(viewModel.title)
//                        .modifier(OnboardingTitleTextViewModifier())
//                    Text(viewModel.subtitle)
//                        .modifier(OnboardingSubTitleTextViewModifier())
//                }
//                .multilineTextAlignment(.center)
