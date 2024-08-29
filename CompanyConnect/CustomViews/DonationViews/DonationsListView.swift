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
    @Binding var privacyStateEnabled: Bool
    @Binding var showPieChart: Bool

    var body: some View {
        List {
            Section {
                if showPieChart {
                    DonationChartView(donations: createChartData(),
                                      privacyStateEnabled: $privacyStateEnabled)
                    .frame(height: UIScreen.main.bounds.width)
                }
                ForEach(pastDonations) {
                    DonationCellView(donation: $0,
                                     privacyStateEnabled: $privacyStateEnabled)
                }
            }
            Section {
                ForEach(scheduledDonations) {
                    DonationCellView(donation: $0, 
                                     privacyStateEnabled: $privacyStateEnabled)
                }
            }
        header: {
            Text("Scheduled Donations")
                .font(.title3)
        } footer: {
            Text(StringGenerator.generateShortString())
                .font(.caption)
                .padding([.vertical])
            }
        }
        .scrollIndicators(.hidden)
    }

    func createChartData() -> [DonationChartDataPoint] {
        var categoryDictionary = [String: DonationChartDataPoint]()
        for donation in pastDonations { // Only past donations for now
            if let catecory = categoryDictionary[donation.category.id] {
                catecory.addAmount(donation.amountInCents)
            } else {
                categoryDictionary[donation.category.id] = DonationChartDataPoint(
                    category: donation.category,
                    amountDonated: donation.amountInCents
                )
            }
        }
        return categoryDictionary.values.map { $0 }.sorted{ $0.amountDonated > $1.amountDonated }
    }
}

#Preview {
    DonationsView()
}
