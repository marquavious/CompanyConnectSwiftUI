//
//  BlurView.swift
//  CompanyConnect
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
        // NO-OP
    }
}

extension UIVisualEffectView {

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self.contentView ? nil : view
    }
}
