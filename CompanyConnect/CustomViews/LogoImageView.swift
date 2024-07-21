//
//  LogoImageView.swift
//  CompanyConnect
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
    let systemLogo: Image
    let logoBackground: Image?
    let themeColor: Color
}

struct LogoImageView: View {

    let systemLogo: Image
    let logoBackground: Image?
    let themeColor: Color
    let size: CGSize

    // I dont like this, but this is the nature of using system
    // Icons as logos.
    var overrideLogoWithFontSize: Font?

    init(
        systemLogo: Image,
        logoBackground: Image? = nil,
        themeColor: Color,
        size: CGSize,
        overrideLogoWithFontSize: Font? = nil
    ) {
        self.systemLogo = systemLogo
        self.logoBackground = logoBackground
        self.themeColor = themeColor
        self.size = size
        self.overrideLogoWithFontSize = overrideLogoWithFontSize
    }

    init(
        logoImageViewData: LogoImageViewData,
        size: CGSize,
        overrideLogoWithFontSize: Font? = nil
    ) {
        self.init(
            systemLogo: logoImageViewData.systemLogo,
            logoBackground: logoImageViewData.logoBackground,
            themeColor: logoImageViewData.themeColor,
            size: size,
            overrideLogoWithFontSize: overrideLogoWithFontSize
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
                .font(overrideLogoWithFontSize)
                .bold()
        }
    }
}
