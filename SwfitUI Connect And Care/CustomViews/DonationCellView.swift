//
//  DonationCellView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/14/24.
//

import Foundation
import SwiftUI

struct DonationCellView: View {

    let donation: Donation

    var body: some View {
        HStack {
            LogoImageView(
                logoImageViewData: donation.company.logoImageData,
                size: CGSize(width: 40, height: 40)
            )

            VStack(alignment: .leading) {
                Text(parseDate(date: donation.date))
                    .font(.subheadline)
                    .bold()

                Text(donation.company.category.name)
                    .font(.system(size: 13))
                    .lineLimit(1)
                    .fontWeight(.semibold)
                    .padding([.vertical], 6)
                    .padding([.horizontal], 6)
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

    private func parseDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

#Preview {
    DonationsView(user: User.createFakeUserData())
}
