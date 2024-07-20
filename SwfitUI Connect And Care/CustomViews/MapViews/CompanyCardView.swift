//
//  CompanyCardView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct CompanyCardView: View {

    struct Constants {
        static let LogoImageViewBackgroundSize: CGSize = CGSize(width: 45, height: 45)
        static let LogoImageViewSize: CGSize = CGSize(width: 40, height: 40)
    }

    var viewModel: MapViewViewModelType
    @Environment(\.colorScheme) var colorScheme

    var onTapAction: ((CompanyObject) -> Void)
    let cellSize: CGSize

    var body: some View {
        ForEach(viewModel.presentedCompanies()) { company in
            ZStack {
                let backgroundColor = colorScheme == .light ?  Color.white : Color.gray.opacity(0.3)

                backgroundColor
                    .cornerRadius(8)
                    .shadow(radius: colorScheme == .light ? 1 : 0)
                HStack(alignment: .top) {
                    let photoSize = CGSize(width: cellSize.width / 3, height: cellSize.height)
                    company.coverImage
                        .resizable()
                        .frame(width: photoSize.height)
                        .id(company.id)
                        .clipped()
                        .cornerRadius(8)
                        .mask(alignment: .bottomLeading) {
                            CurvedRect(
                                cornerRadius: 8,
                                photoSize: Constants.LogoImageViewBackgroundSize
                            )
                        }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(company.orginizationName)
                            .font(.headline)
                            .foregroundColor(
                                colorScheme == .light ? Color.black.opacity(0.7) : .white
                            )
                        Text(company.briefHistoryObject.history)
                            .font(.caption)
                            .foregroundColor(
                                colorScheme == .light ? Color.black.opacity(0.7) : .white
                            )
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    LogoImageView(
                        logoImageViewData: company.logoImageData,
                        size: Constants.LogoImageViewSize
                    )
                }
                .padding(8)
            }
            .onTapGesture { _ in
                onTapAction(company)
            }
        }
    }

}

#Preview {
    MapTabView(viewModel: FakeMapViewViewModel())
}
