//
//  MapAnnotationView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/14/24.
//

import Foundation
import SwiftUI

struct MapAnnotationView: View {

    @State var company: CompanyObject

    var body: some View {
        ZStack {
            VStack(spacing: 1) {
                Circle()
                    .fill(Color.white.opacity(0.7))
                    .frame(width: 40, height: 40)
                    .overlay {
                        LogoImageView(
                            logoImageViewData: company.logoImageData,
                            size: CGSize(width: 30, height: 30)
                        )
                    }
                Triangle()
                    .fill(Color.white.opacity(0.7))
                    .frame(width: 15, height: 10)
                    .rotationEffect(.degrees(180))
            }
        }
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    MapAnnotationView(company: CompanyObject.createFakeComapnyList().first!)
}
