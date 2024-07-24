//
//  DonationsViewViewModel.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation

protocol DonationsViewViewModelType {
    var pastDonations: [Donation] { get }
    var scheduledDonations: [Donation] { get }
}

@Observable
class DonationsViewViewModel: DonationsViewViewModelType {

    var pastDonations: [Donation]
    var scheduledDonations: [Donation]

    init(pastDonations: [Donation], scheduledDonations: [Donation]) {
        self.pastDonations = pastDonations
        self.scheduledDonations = scheduledDonations
    }
}

@Observable
class DevDonationsViewViewModel: DonationsViewViewModelType {
    var pastDonations: [Donation]
    var scheduledDonations: [Donation]
    init() {
        let pastDonations: [Donation] = Donation.generatePastDonations()
        let scheduledDonations: [Donation] = Donation.generateScheduledDonations()
        self.pastDonations = pastDonations
        self.scheduledDonations = scheduledDonations
    }
}
