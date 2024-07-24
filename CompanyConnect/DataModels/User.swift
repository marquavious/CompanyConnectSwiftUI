//
//  User.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct User: Codable {

    let name: String
    let donations: [Donation]
    let scheduledDonations: [Donation]
}

extension User {
    static func createFakeUserData() -> User {
        User(
            name: "Johnny Appleseed",
            donations: Donation.generatePastDonations(),
            scheduledDonations: Donation.generateScheduledDonations ()
        )
    }
}
