//
//  Donation.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct Donation: Codable, Identifiable {

    enum PaymentMethod: String, Codable, CaseIterable {
        case creditCard = "credit_card", paypal = "paypal", applePay = "apple_pay"

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

    let id: String
    let amountInCents: Double
    let date: Date
    let paymentMethod: PaymentMethod
    let orginizationName: String
    let category: Category
    let comapnyLogoUrl: String
}

extension Donation {
    func displayAmount() -> String {
        return "$\(String(format: "%.0f", amountInCents))"
    }

    // TODO: - Merge Below Functions

    static func generatePastDonations(donationCount: Int = 5) -> [Donation] {
        var array = [Donation]()
        for _ in 0...donationCount {
            array.append(
                Donation(
                    id: UUID().uuidString,
                    amountInCents: Double.random(in: 0...500),
                    date: Calendar.current.date(
                        byAdding: .day,
                        value: Int.random(in: -10 ... -1),
                        to: Date())!,
                    paymentMethod: PaymentMethod.allCases.randomElement()!, 
                    orginizationName: "Company",
                    category: Category.allCases.randomElement()!,
                    comapnyLogoUrl: "img_url"
                )
            )
        }

        return array.sorted { $0.date < $1.date }
    }

    static func generateScheduledDonations(donationCount: Int = 5) -> [Donation] {
        var array = [Donation]()
        for _ in 0...donationCount {
            array.append(
                Donation(
                    id: UUID().uuidString,
                    amountInCents: Double.random(in: 0...500),
                    date: Calendar.current.date(
                        byAdding: .day,
                        value: Int.random(in: 1 ... 10),
                        to: Date())!,
                    paymentMethod: PaymentMethod.allCases.randomElement()!,
                    orginizationName: "Company",
                    category: Category.allCases.randomElement()!,
                    comapnyLogoUrl: "img_url"
                )
            )
        }

        return array.sorted { $0.date < $1.date }
    }
}
