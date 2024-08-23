//
//  DonationsViewViewModel.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation
import Factory
import Firebase
import FirebaseFirestore

extension Container {
    var donationsService: Factory<DonationServiceType> {
        switch AppConfig.shared.enviorment {
        case .production:
            self { FirebaseDonationsService() }
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
class FirebaseDonationsService: DonationServiceType, ObservableObject {
    func getDonationsData(forUserID id: String) async throws -> DonationsViewJSONResponse {
        do {
            /* This would be used if we were using the real time database. Un-comment to do so
            // let snapshot = try await Database.database().reference().child("company_objects").child("company_objects").getData()
            // let cleanArray = try snapshot.data(as: [Company?].self).compactMap { $0 }
            // data(as: [Company?].self).compactMap { $0 }
            */

            let pastSnapshot = try await Firestore
                .firestore()
                .collection(FirebaseDataStoreRoute.pastDonations.route)
                .document(id)
                .collection("donations")
                .getDocuments()

            let pastDonationsArray = try pastSnapshot.documents.compactMap { document in
                try document.data(as: Donation.self)
            }

            let scheduledSnapshot = try await Firestore
                .firestore()
                .collection(FirebaseDataStoreRoute.scheduledDonations.route)
                .document(id)
                .collection("donations")
                .getDocuments()

            let scheduledDonationsArray = try scheduledSnapshot.documents.compactMap { document in
                try document.data(as: Donation.self)
            }

            return DonationsViewJSONResponse(pastDonations: pastDonationsArray, scheduledDonations: scheduledDonationsArray)
        }
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
