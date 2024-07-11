//
//  DonationsView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI

struct DonationsView: View {
    @Environment (\.colorScheme) var colorScheme

    let userData = User(name: "Cack", donations: Donation.generateDonations(), scheduledDonations: [Donation(
        amountInCents: 205,
        company: CompanyObject.ceateFakeComapnyList().randomElement()!,
        date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        paymentMethod: .paypal
    )])
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(userData.donations, id: \.id) { donation in
                        DonationCellView(donation: donation)
                    }
                }
                Section {
                    ForEach(userData.scheduledDonations, id: \.id) { donation in
                        DonationCellView(donation: donation)
                    }
                }
            header: {
                Text("Scheduled")
                    .font(.title3)
                    .padding([.vertical])
            } footer: {
                Text(CompanyObject.generateShort())
                    .font(.caption)
                    .padding([.vertical])
                }
            }
            .contentMargins([.top], 16)
            .navigationTitle("Donations")
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
            .toolbar {
                Button("", systemImage: "plus.circle") {
                }.tint(colorScheme == .light ? .black:.white)
            }
        }
    }
}

#Preview {
    DonationsView()
}

extension Color {
    static func random() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

struct DonationCellView: View {

    let donation: Donation

    var body: some View {
        HStack {

            if donation.company.shouldUseSolidColorBackground {

                Circle()
                    .fill(donation.company.themeColor)
                    .frame(width: 40, height: 40)
                    .overlay(alignment: .center) {
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .mask {
                                VStack(spacing: 0) {
                                    Text(Image(systemName: donation.company.logoSystemName))
                                        .font(donation.company.radomShowShorthandName ? .caption : .title2)
                                        .bold()

                                    if donation.company.radomShowShorthandName {
                                        Text(String(donation.company.orginizationName.prefix(3)).uppercased())
                                            .font(.caption)
                                            .bold()
                                    }
                                }
                            }
                    }
            } else {
                donation.company.logo
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .overlay(alignment: .center) {
                        Color.white
                            .mask {
                                VStack(spacing: 0) {
                                    Text(Image(systemName: donation.company.logoSystemName))
                                        .font(donation.company.radomShowShorthandName ? .caption : .title2)
                                        .bold()

                                    if donation.company.radomShowShorthandName {
                                        Text(String(donation.company.orginizationName.prefix(3)).uppercased())
                                            .font(.caption)
                                            .bold()
                                    }
                                }
                            }
                    }
                    .clipShape(Circle())
            }

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

    func parseDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}
