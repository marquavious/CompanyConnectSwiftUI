//
//  File.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/16/24.
//

import Foundation
import SwiftUI

struct DonationProgessView: View {

    struct Constants {
        static let ButtonCornerRadius: CGFloat = 8
        static let HorizontalPadding: CGFloat = 16
        static let DonationProgessView: CGFloat = 120
    }

    @Environment (\.colorScheme) var colorScheme

    let donationProgress: Double
    let donationTotal: Double

    var body: some View {
        GeometryReader { proxy in

            let percentageMultiplier: Double = 100
            let proxyWidth: CGFloat = proxy.frame(in: .local).width
            let progressBarHeight: CGFloat = 15
            let percenttageAmountFuFilled = (( donationProgress / donationTotal) * percentageMultiplier)
            let color1 = Color(Color.orange)
            let color2 = Color(Color.red)
            let multiplier = proxyWidth / percentageMultiplier
            let backgroundProgressBarColor = colorScheme == .light ? Color.gray.opacity(0.3) : Color.gray.opacity(0.3)

            VStack(alignment: .center, spacing: 16) {
                HStack {
                    Text("$\(String(format: "%.0f", donationProgress))")
                        .font(.title)

                    Text("/ $\(String(format: "%.0f", donationTotal))")
                        .font(.title)
                        .opacity(0.5)
                }

                ZStack(alignment: .leading) {
                    RoundedRectangle(
                        cornerRadius: progressBarHeight,
                        style: .continuous)
                    .frame(
                        maxWidth: proxyWidth,
                        maxHeight: progressBarHeight
                    )
                    .foregroundColor(backgroundProgressBarColor)
                    RoundedRectangle(
                        cornerRadius: progressBarHeight,
                        style: .continuous)
                    .frame(
                        maxWidth: percenttageAmountFuFilled * multiplier,
                        maxHeight: progressBarHeight
                    )
                    .background(
                        LinearGradient(
                            colors: [color1, color2],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .clipShape(RoundedRectangle(cornerRadius: progressBarHeight, style: .continuous))
                    )
                    .foregroundColor(.clear)
                }
                .padding([.horizontal], Constants.HorizontalPadding)

                Button("DONATE") {
                    // - TODO: ADD DONATION FLOW
                }
                .background(colorScheme == .light ? .red : .gray.opacity(0.3))
                .foregroundColor(.white)
                .buttonStyle(.bordered)
                .font(.subheadline)
                .bold()
                .clipShape(RoundedRectangle(cornerRadius: Constants.ButtonCornerRadius))
            }
        }
        .frame(height: Constants.DonationProgessView)
    }

}

#Preview() {
    DonationProgessView(donationProgress: 500, donationTotal: 100)
}
