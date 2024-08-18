//
//  DonationsViewViewModel.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation
import Factory

extension Container {
    var donationsViewService: Factory<DonationsViewServiceType> {
        self { DevDonationsService() }
    }
}

protocol DonationsViewServiceType: HTTPDataDownloader {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse
}

@Observable
class OfflineDonationsService: DonationsViewServiceType, ObservableObject {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse {
        return try await getData(as: DonationsViewJSONResponse.self, from: URLBuilder.donations(userID: id).url)
    }
}

@Observable
class DevDonationsService: DonationsViewServiceType, ObservableObject {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse {
        return DonationsViewJSONResponse(
            pastDonations: Donation.generatePastDonations(),
            scheduledDonations: Donation.generateScheduledDonations()
        )
    }
}
