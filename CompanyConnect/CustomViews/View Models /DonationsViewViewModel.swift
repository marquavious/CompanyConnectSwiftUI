//
//  DonationsViewViewModel.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation

protocol DonationsViewViewModelType {
    var donations: [Donation] { get }
}

@Observable
class DonationsViewViewModel: DonationsViewViewModelType {

    let donations: [Donation]

    init(donations: [Donation]) {
        self.donations = donations
    }
}

@Observable
class DevDonationsViewViewModel: DonationsViewViewModelType {
    let donations: [Donation] = Donation.generatePastDonations()
}
