//
//  DonationsListView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation
import SwiftUI

struct DonationsListView: View {

    struct Constants {
        static let ContentPadding = EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
    }

    @State var pastDonations: [Donation]
    @State var scheduledDonations: [Donation]

    var body: some View {
        List {
            Section {
                ForEach(pastDonations) {
                    DonationCellView(donation: $0)
                }
            }
            Section {
                ForEach(scheduledDonations) {
                    DonationCellView(donation: $0)
                }
            }
        header: {
            Text("Scheduled")
                .font(.title3)
                .padding([.vertical])
        } footer: {
            Text(StringGenerator.generateShortString())
                .font(.caption)
                .padding([.vertical])
        }
        }
        .contentMargins([.top], Constants.ContentPadding)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    DonationsView()
}
