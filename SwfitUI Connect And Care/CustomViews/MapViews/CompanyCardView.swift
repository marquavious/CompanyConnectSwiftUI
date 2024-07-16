//
//  CompanyCardView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct CompanyCardView: View {

    var onTapAction: ((CompanyObject) -> Void)
    let cellSize: CGSize
    @EnvironmentObject var viewModel: MapViewViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ForEach(viewModel.presentedCompanies) { company in
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
                            CurvedRectShape(cornerRadius: 8, photoSize: CGSize(width: 45, height: 45))
                        }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(company.orginizationName)
                            .font(.headline)
                            .foregroundColor(
                                colorScheme == .light ? Color.black.opacity(0.7) : .white
                            )
                        Text(company.missionStatement)
                            .font(.caption)
                            .foregroundColor(
                                colorScheme == .light ? Color.black.opacity(0.7) : .white
                            )
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    LogoImageView(logoImageViewData: company.logoImageData, size: CGSize(width: 40, height: 40))
                }
                .padding(8)
            }
            .onTapGesture { _ in
                onTapAction(company)
            }
        }
    }
}
