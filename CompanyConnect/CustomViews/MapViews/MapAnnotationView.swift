//
//  MapAnnotationView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/14/24.
//

import Foundation
import SwiftUI

struct MapAnnotationView: View {

    struct Constants {
        static let AnnotationSize: CGSize = CGSize(width: 40, height: 40)
        static let LogoSize: CGSize = CGSize(width: 30, height: 30)
    }

    @State var company: CompanyObject

    var body: some View {
        ZStack {
            VStack(spacing: 1) {
                Circle()
                    .fill(Color.white.opacity(0.7))
                    .frame(
                        width: Constants.AnnotationSize.width,
                        height: Constants.AnnotationSize.height
                    )
                    .overlay {
                        AsyncImage(url: URL(string: company.coverImageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)

                        } placeholder: {
                            Color.gray
                        }
                        .frame(
                            width: Constants.LogoSize.width,
                            height: Constants.LogoSize.height
                        )
                        .clipShape(Circle())

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
