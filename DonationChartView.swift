//
//  DonationChartView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/27/24.
//

import Foundation

import SwiftUI
import Charts

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let revenue: Double
}

struct DonationChartView: View {

    @State var donations: [DonationChartDataPoint]

    init(donations: [Donation]) {
        // TODO: - Optimize
        var categoryDictionary = [String: DonationChartDataPoint]()
        for donation in donations {
            if var catecory = categoryDictionary[donation.category.id] {
                catecory.addAmount(donation.amountInCents)
            } else {
                categoryDictionary[donation.category.id] = DonationChartDataPoint(
                    category: donation.category,
                    amountDonated: donation.amountInCents
                )
            }
        }
        self.donations = categoryDictionary.values.map { $0 }.sorted{ $0.amountDonated > $1.amountDonated }
    }
    var body: some View {
        Chart(donations) { product in
            SectorMark(
                angle: .value(
                    Text(verbatim: product.category.name),
                    product.amountDonated
                ),
                angularInset: 1
            )
            .foregroundStyle(product.category.color)
            .annotation(position: .overlay) {
                VStack {
                    Text("\(product.category.name)")
                    Text("$\(String(format: "%.0f", product.amountDonated))")
                }
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    DonationChartView(donations: Donation.generatePastDonations())
}

struct DonationChartDataPoint: Identifiable {
    let category: Category
    var amountDonated: Double

    var id: String {
        return UUID().uuidString
    }

    mutating func addAmount(_ amount: Double) {
        self.amountDonated += amount
    }
}
