//
//  DonationsViewViewModel.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation

protocol DonationsViewViewModelType {
    func loadDonationsData() async
    var pastDonations: [Donation] { get }
    var scheduledDonations: [Donation] { get }
}

protocol DonationsViewServiceType: HTTPDataDownloader {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse
}

class OfflineDonationsServiceType: DonationsViewServiceType {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse {
        return try await getData(as: DonationsViewJSONResponse.self, from: URLBuilder.donations(userID: id).url)
    }
}

@Observable
class OfflineDonationsViewViewModel: DonationsViewViewModelType {
    var pastDonations = [Donation]()
    var scheduledDonations = [Donation]()

    private let service = OfflineDonationsServiceType()

    func loadDonationsData() async {
        do {
            let donationsData = try await service.getDonationsData(forUserID: "")
            pastDonations = donationsData.pastDonations
            scheduledDonations = donationsData.scheduledDonations
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

@Observable
class DonationsViewViewModel: DonationsViewViewModelType {

    var pastDonations: [Donation]
    var scheduledDonations: [Donation]

    init(pastDonations: [Donation], scheduledDonations: [Donation]) {
        self.pastDonations = pastDonations
        self.scheduledDonations = scheduledDonations
    }

    func loadDonationsData() async { }
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

    func loadDonationsData() async { }
}
