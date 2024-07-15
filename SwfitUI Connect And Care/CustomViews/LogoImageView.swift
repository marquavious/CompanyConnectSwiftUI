//
//  LogoImageView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct LogoImageData {
    let showCompanyAbbreviation: Bool
    let systemLogo: Image
    let logoBackground: Image?
    let themeColor: Color
}

struct LogoImageViewData {
    let companyAbbreviation: String
    let addAbbreviationToLogo: Bool
    let systemLogo: Image
    let logoBackground: Image?
    let themeColor: Color
}

struct LogoImageView: View {

    let companyAbbreviation: String?
    let addAbbreviationToLogo: Bool
    let systemLogo: Image
    let logoBackground: Image?
    let themeColor: Color
    let size: CGSize
    let showIconOnly: Bool

    init(
        companyAbbreviation: String?,
        addAbbreviationToLogo: Bool,
        systemLogo: Image,
        logoBackground: Image? = nil,
        themeColor: Color,
        size: CGSize,
        showIconOnly: Bool
    ) {
        self.companyAbbreviation = companyAbbreviation
        self.addAbbreviationToLogo = addAbbreviationToLogo
        self.systemLogo = systemLogo
        self.logoBackground = logoBackground
        self.themeColor = themeColor
        self.size = size
        self.showIconOnly = showIconOnly
    }

    init(
        logoImageViewData: LogoImageViewData,
        showIconOnly: Bool = false,
        size: CGSize
    ) {
        self.init(
            companyAbbreviation: logoImageViewData.companyAbbreviation,
            addAbbreviationToLogo: logoImageViewData.addAbbreviationToLogo,
            systemLogo: logoImageViewData.systemLogo,
            logoBackground: logoImageViewData.logoBackground,
            themeColor: logoImageViewData.themeColor,
            size: size,
            showIconOnly: showIconOnly
        )
    }

    var body: some View {
        if let logoBackground {
            logoBackground
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: size.height)
                .clipShape(Circle())
                .overlay(alignment: .center) {
                    Color.white.mask { crateLogoMask() }
                }
        } else {
            Circle()
                .fill(themeColor)
                .frame(width: size.width, height: size.height)
                .clipShape(Circle())
                .overlay(alignment: .center) {
                    Color.white.mask { crateLogoMask() }
                }
        }
    }

    @ViewBuilder
    private func crateLogoMask() -> some View {
        VStack(spacing: .zero) {
            Text(systemLogo)
                .font(addAbbreviationToLogo && !showIconOnly ? .caption : .title2)
                .bold()

            if let companyAbbreviation = companyAbbreviation, addAbbreviationToLogo, !showIconOnly {
                Text(companyAbbreviation)
                    .font(.caption2)
                    .bold()
            }
        }
    }
}
