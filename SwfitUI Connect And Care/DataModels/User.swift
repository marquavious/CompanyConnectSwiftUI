//
//  User.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct User: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let donations: [Donation]
    let scheduledDonations: [Donation]
}

extension User {
    static func createFakeUserData(user: User? = nil) -> User {
        if let user = user { return user }

        return User(
            name: "Fake User",
            donations: Donation.generateDonations(),
            scheduledDonations:
                [
                    Donation(
                        amountInCents: 205,
                        company: CompanyObject.createFakeComapnyList().randomElement()!,
                        date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                        paymentMethod: .paypal
                    ),

                    Donation(
                        amountInCents: 205,
                        company: CompanyObject.createFakeComapnyList().randomElement()!,
                        date: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
                        paymentMethod: .paypal
                    )
                ]
        )
    }
}
