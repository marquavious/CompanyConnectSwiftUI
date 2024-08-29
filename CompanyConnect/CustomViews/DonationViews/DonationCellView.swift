//
//  DonationCellView.swift
//  CompanyConnect
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

    @Binding var privacyStateEnabled: Bool

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: donation.comapnyLogoUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(
                width: Constants.LogoImageViewSize.width,
                height: Constants.LogoImageViewSize.height
            )
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(Date.parseDate(date: donation.date))
                    .font(.subheadline)
                    .bold()

                Text(donation.category.name)
                    .font(.system(size: 13))
                    .lineLimit(1)
                    .fontWeight(.semibold)
                    .padding([.vertical, .horizontal], Constants.CategoryNamePadding)
                    .foregroundColor(.white)
                    .background(donation.category.color)
                    .lineLimit(1)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(donation.orginizationName)
            }

            Spacer()

            VStack(alignment: .trailing) {
                Text(privacyStateEnabled ?  "$ ---": donation.displayAmount())
                    .bold()
                Text(privacyStateEnabled ?  "": donation.paymentMethod.displayName)
            }
        }
    }
}

#Preview {
    DonationsView()
}
