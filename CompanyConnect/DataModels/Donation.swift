//
//  Donation.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct Donation: Codable, Identifiable {
    
    enum CodingKeys:String, CodingKey {
        case id = "id"
        case amountInCents = "amount_in_cents"
        case date = "date"
        case paymentMethod = "payment_method"
        case orginizationName = "orginization_name"
        case category = "category"
        case comapnyLogoUrl = "comapny_logo_url"
    }
 
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

    init(
    id: String,
    amountInCents: Double,
    date: String,
    paymentMethod: PaymentMethod,
    orginizationName: String,
    category: Category,
    comapnyLogoUrl: String
    ) {
        self.id = id
        self.amountInCents = amountInCents
        self.paymentMethod = paymentMethod
        self.orginizationName = orginizationName
        self.category = category
        self.comapnyLogoUrl = comapnyLogoUrl

        if let dateFrdateomFormatter = ISO8601DateFormatter().date(from: date) {
            self.date = dateFrdateomFormatter
        } else {
            self.date = Date()
            // Log
        }
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        amountInCents = try container.decode(Double.self, forKey: .amountInCents)
        paymentMethod = try container.decode(PaymentMethod.self, forKey: .paymentMethod)
        orginizationName = try container.decode(String.self, forKey: .orginizationName)
        category = try container.decode(Category.self, forKey: .category)
        comapnyLogoUrl = try container.decode(String.self, forKey: .comapnyLogoUrl)

        let dateString = try container.decode(String.self, forKey: .date)
        if let dateFromFormatter = ISO8601DateFormatter().date(from: dateString) {
            date = dateFromFormatter
        } else {
            date = Date()
            // Log
        }
    }

    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(amountInCents, forKey: .amountInCents)
        try container.encode(date, forKey: .date)
        try container.encode(paymentMethod, forKey: .paymentMethod)
        try container.encode(amountInCents, forKey: .orginizationName)
        try container.encode(category, forKey: .category)
        try container.encode(comapnyLogoUrl, forKey: .comapnyLogoUrl)
    }
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
                        to: Date())!.ISO8601Format(),
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
                        to: Date())!.ISO8601Format(),
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
