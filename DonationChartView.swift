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

    enum ChartTabs: Int, CaseIterable {
        case pie, bar
    }

    @State var donations: [DonationChartDataPoint]
    @State private var currentTab: ChartTabs = .bar
    @Binding var privacyStateEnabled: Bool

    var body: some View {
        VStack(spacing: 16) {
            switch currentTab {
            case .pie:
                Chart(donations, id: \.id) { product in
                    SectorMark(
                        angle: .value(
                            Text(verbatim: product.category.name),
                            product.amountDonated
                        ),
//                        innerRadius: .ratio(0.6),
                        angularInset: 1
                    )
                    .foregroundStyle(product.category.color)
                    .annotation(position: .overlay) {
                        VStack {
                            Text("\(product.category.name)")
                            if !privacyStateEnabled {
                                Text("$\(String(format: "%.0f", product.amountDonated))")
                            }
                        }
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    }
                }
                .pickerStyle(.segmented)
            case .bar:
                Chart {
                    ForEach(donations) { product in
                        BarMark(
                            x: .value("Category", product.category.name),
                            y: .value("Amount", product.amountDonated)
                        )
                        .foregroundStyle(product.category.color)
                        .annotation(position: .overlay) {
                            Text("$\(String(format: "%.0f", product.amountDonated))")
                                .font(.system(size: 10))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .rotationEffect(.degrees(-90))
                                .opacity(privacyStateEnabled ? 0 : 1)
                        }
                    }
                }
            }

            Picker("", selection: $currentTab) {
                switch currentTab {
                case .bar:
                    Image(systemName: "chart.pie").tag(ChartTabs.pie)
                    Image(systemName: "chart.bar.fill").tag(ChartTabs.bar)
                case .pie:
                    Image(systemName: "chart.pie.fill").tag(ChartTabs.pie)
                    Image(systemName: "chart.bar").tag(ChartTabs.bar)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    DonationsView()
}

class DonationChartDataPoint: Identifiable {
    let category: Category
    var amountDonated: Double

    var id: String {
        return UUID().uuidString
    }

    func addAmount(_ amount: Double) {
        self.amountDonated += amount
    }

    init(category: Category, amountDonated: Double) {
        self.category = category
        self.amountDonated = amountDonated
    }
}
