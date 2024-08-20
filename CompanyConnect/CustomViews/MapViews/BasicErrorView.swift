//
//  BasicErrorView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation
import SwiftUI

struct BasicErrorView<Background: View>: View {
    var retryAction: () -> Void
    var errorString: String
    var background: Background

    init(errorString: String,
         background: Background,
         retryAction: @escaping () -> Void) {
        self.retryAction = retryAction
        self.errorString = errorString
        self.background = background
    }

    var body: some View {
        background
            .opacity(0.3)
            .overlay {
                VStack(spacing: 8) {
                    Text("Error")
                        .bold()
                    Text(errorString)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Button {
                        retryAction()
                    } label: {
                        Text("Reload ⟳")
                    }
                }
            }
            .padding()
    }
}

#Preview {
    BasicErrorView(
        errorString: "Oh NO! It's OVER Oh NO! It's OVER Oh NO! It's OVER Oh NO!",
        background: Color.white,
        retryAction: { }
    )
}
