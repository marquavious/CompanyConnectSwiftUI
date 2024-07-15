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
                            LogoImageView(logoImageViewData: company.logoImageData, showIconOnly: true, size: CGSize(width: 30, height: 30))

                            // company.logoImageData.createIconView(company: company, showCompanyAbbreviationTwo: false, size: CGSize(width: 30, height: 30))
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
    MapAnnotationView(company: CompanyObject.ceateFakeComapnyList().first!)
}

//if company.logoImage {
//    Circle()
//        .fill(company.themeColor)
//        .frame(width: 30, height: 30)
//        .overlay(alignment: .center) {
//            Color.white
//                .clipShape(RoundedRectangle(cornerRadius: 8))
//                .clipShape(RoundedRectangle(cornerRadius: 8))
//                .mask {
//                    VStack(spacing: 0) {
//                        Text(Image(systemName: company.logoSystemName))
//                            .font(.title2)
//                            .bold()
//                    }
//                }
//        }
//} else {
//    company.logo
//        .resizable()
//        .scaledToFill()
//        .frame(width: 30, height: 30)
//        .clipShape(Circle())
//        .overlay(alignment: .center) {
//            Color.white
//                .mask {
//                    VStack(spacing: 0) {
//                        Text(Image(systemName: company.logoSystemName))
//                            .font(.title2)
//                            .bold()
//                    }
//                }
//        }
//        .clipShape(Circle())
//}
