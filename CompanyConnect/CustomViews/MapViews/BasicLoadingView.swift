//
//  BasicLoadingView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation
import SwiftUI

struct BasicLoadingView<Background: View>: View {
    var titleString: String
    var background: Background

    init(titleString: String, background: Background) {
        self.titleString = titleString
        self.background = background
    }

    var body: some View {
        Rectangle()
            .fill(.clear)
            .background(background)
            .ignoresSafeArea()
            .opacity(0.9)
            .overlay {
                VStack(spacing: 0) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 50, height: 50)
                    Text(titleString)
                        .foregroundColor(.gray)
                }
            }
    }
}

#Preview {
    BasicLoadingView(titleString: "Loading with custom text...", background: Color.white)
}
