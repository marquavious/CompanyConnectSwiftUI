//
//  DonationCellView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/14/24.
//

import Foundation
import SwiftUI

struct DonationCellView: View {

    struct Constants {
        static let LogoImageViewSize: CGSize =  CGSize(width: 40, height: 40)
        static let CategoryNamePadding: CGFloat = 6
    }

    let donation: Donation

    var body: some View {
        HStack {
            LogoImageView(
                logoImageViewData: donation.company.logoImageData,
                size: Constants.LogoImageViewSize
            )

            VStack(alignment: .leading) {
                Text(Date.parseDate(date: donation.date))
                    .font(.subheadline)
                    .bold()

                Text(donation.company.category.name)
                    .font(.system(size: 13))
                    .lineLimit(1)
                    .fontWeight(.semibold)
                    .padding([.vertical, .horizontal], Constants.CategoryNamePadding)
                    .foregroundColor(.white)
                    .background(donation.company.category.color)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(donation.company.orginizationName)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(donation.displayAmount())
                    .bold()
                Text(donation.paymentMethod.displayName)
            }
        }
    }

}

#Preview {
    DonationsView(user: User.createFakeUserData())
}
