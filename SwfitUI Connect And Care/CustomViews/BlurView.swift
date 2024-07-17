//
//  BlurView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 12/21/23.
//

import SwiftUI

struct BlurView: UIViewRepresentable {

    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }

}
