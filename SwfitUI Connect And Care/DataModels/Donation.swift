//
//  Donation.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct Donation: Hashable, Identifiable {

    enum PaymentMethod {
        case creditCard, paypal, applePay

        var displayName: String {
            switch self {
            case .creditCard:
                return "Credit Card"
            case .paypal:
                return "PayPal"
            case .applePay:
                return "Apple Pay"
            }
        }
    }

    let id = UUID()
    let amountInCents: Double
    let company: CompanyObject
    let date: Date
    let paymentMethod: PaymentMethod

    func displayAmount() -> String {
        return "$\(String(format: "%.0f", amountInCents))"
    }

    static func generateDonations() -> [Donation] {
        return [
            Donation(
                amountInCents: 100,
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                paymentMethod: .applePay),
            Donation(
                amountInCents: 200,
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                paymentMethod: .creditCard),
            Donation(
                amountInCents: 205,
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
                paymentMethod: .paypal),
            Donation(
                amountInCents: 100,
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                paymentMethod: .applePay),
            Donation(
                amountInCents: 200,
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                paymentMethod: .creditCard
            ),
            Donation(
                amountInCents: 205,
                company: CompanyObject.createFakeComapnyList().randomElement()!,
                date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                paymentMethod: .paypal
            )
        ].sorted { donationOne, donationTwo in
            donationOne.date < donationTwo.date
        }
    }
}
