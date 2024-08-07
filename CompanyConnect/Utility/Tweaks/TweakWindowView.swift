//
//  TweakWindowView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/26/24.
//

import Foundation
import SwiftUI

struct TweakWindowView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                TweakWindowUIViewControllerRepresentable()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("CC Tweaks")
            .toolbar {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    TweakWindowView()
}
