//
//  DonationsTabView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import Charts

struct DonationsView: View {

    struct Constants {
        static let ContentPadding = EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        static let HeaderTitle = "Scheduled"
        static let NavigationTitle = "Donations"
    }

    private enum Icons: String {
        case RightToolbar = "plus.circle"
    }

    var donationSalesTwo = Donation.generatePastDonations()

    @Environment (\.colorScheme) var colorScheme

    let user: User

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(user.donations) {
                        DonationCellView(donation: $0)
                    }
                }
                Section {
                    ForEach(user.scheduledDonations) {
                        DonationCellView(donation: $0)
                    }
                }
            header: {
                Text(Constants.HeaderTitle)
                    .font(.title3)
                    .padding([.vertical])
            } footer: {
                // - TODO: Replace Fake Text with Text Generators
                Text(StringGenerator.generateShortString())
                    .font(.caption)
                    .padding([.vertical])
                }
            }
            .contentMargins([.top], Constants.ContentPadding)
            .navigationTitle(Constants.NavigationTitle)
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
            .toolbar {
                Button(
                    String(),
                    systemImage: Icons.RightToolbar.rawValue
                ) {
                    // - TODO: Add donation flow
                }
                .tint(colorScheme == .light ? .black:.white)
            }

        }
    }

}

#Preview {
    DonationsView(user: User.createFakeUserData())
}
