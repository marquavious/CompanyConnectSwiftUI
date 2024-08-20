//
//  DarkThemedNavBarView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation
import SwiftUI

struct DarkThemedNavBarView: View {

    struct Constants {
        static let NavigationBarHeight: CGFloat = 50
    }

    @State var title: String
    @Environment(\.dismiss) var dismiss
    @Binding var showNavigationBar: Bool

    var body: some View {
        ZStack {
            BlurView()
                .ignoresSafeArea()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: Constants.NavigationBarHeight
                )
                .opacity(showNavigationBar ? 1 : 0)
                .overlay(alignment: .center) {
                    Text(title)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .opacity(showNavigationBar ? 1 : 0)
                }

            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 20,height: 20)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(
                        .background
                            .opacity(showNavigationBar ? 0 : 0.5)
                    )
                    .environment(\.colorScheme, .dark)
                    .clipShape(Circle())
                    .padding([.horizontal])
                    .allowsHitTesting(true)
                    .onTapGesture { dismiss() }
                    .background(Rectangle().fill(Color.black.opacity(0.0001)))
                Spacer()
            }
        }
    }
}
