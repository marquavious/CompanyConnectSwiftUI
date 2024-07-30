//
//  DonationsViewViewModel.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation

protocol DonationsViewViewModelType {
    var loadingState: LoadingState { get }
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
    var loadingState: LoadingState = . loading
    var pastDonations = [Donation]()
    var scheduledDonations = [Donation]()

    private let service = OfflineDonationsServiceType()

    func loadDonationsData() async {
        loadingState = .loading
        do {
            let donationsData = try await service.getDonationsData(forUserID: "")
            pastDonations = donationsData.pastDonations
            scheduledDonations = donationsData.scheduledDonations
            loadingState = .fetched
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
                nsError.code == NSURLErrorCancelled {
                //Handle cancellation
            } else {
                //Handle failure
                loadingState = .error(error)
            }
        }
    }
}

@Observable
class DonationsViewViewModel: DonationsViewViewModelType {
    var loadingState: LoadingState = .fetched
    var pastDonations: [Donation]
    var scheduledDonations: [Donation]

    init(pastDonations: [Donation], scheduledDonations: [Donation]) {
        self.pastDonations = pastDonations
        self.scheduledDonations = scheduledDonations
    }

    func loadDonationsData() async { loadingState = .fetched}
}

@Observable
class DevDonationsViewViewModel: DonationsViewViewModelType {
    var loadingState: LoadingState
    var pastDonations: [Donation]
    var scheduledDonations: [Donation]
    
    init(loadingState: LoadingState = .fetched) {
        let pastDonations: [Donation] = Donation.generatePastDonations()
        let scheduledDonations: [Donation] = Donation.generateScheduledDonations()
        self.pastDonations = pastDonations
        self.scheduledDonations = scheduledDonations
        self.loadingState = loadingState
    }

    func loadDonationsData() async { }
}
