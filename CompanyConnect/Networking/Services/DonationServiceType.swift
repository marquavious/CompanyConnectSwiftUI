//
//  DonationsViewViewModel.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation
import Factory

extension Container {
    var donationsService: Factory<DonationServiceType> {
        switch AppConfig.shared.enviorment {
        case .production:
            self { DonationsService() }
        case .offline:
            self { OfflineDonationsService() }
        case .development:
            self { DevDonationsService() }
        }
    }
}

protocol DonationServiceType: HTTPDataDownloader {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse
}

@Observable
class DonationsService: DonationServiceType, ObservableObject {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse {
        return try await getData(as: DonationsViewJSONResponse.self, from: URLBuilder.donations(userID: id).url)
    }
}

@Observable
class OfflineDonationsService: DonationServiceType, ObservableObject {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse {
        return try await getData(as: DonationsViewJSONResponse.self, from: URLBuilder.donations(userID: id).url)
    }
}

@Observable
class DevDonationsService: DonationServiceType, ObservableObject {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse {
        return DonationsViewJSONResponse(
            pastDonations: Donation.generatePastDonations(),
            scheduledDonations: Donation.generateScheduledDonations()
        )
    }
}
