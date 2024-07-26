//
//  DonationsViewJSONResponse.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/24/24.
//

import Foundation

struct DonationsViewJSONResponse: Codable {
    let pastDonations: [Donation]
    let scheduledDonations: [Donation]
}
