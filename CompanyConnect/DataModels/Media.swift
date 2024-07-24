//
//  MediaData.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation
import SwiftUI

enum Media: Codable {
    static var allCases = ["photo", "photo_carousel", "donation_progress"]

    case photo(photoUrl:String)
    case photoCarousel(photoUrls: [String])
    case donationProgress(amountRaised:Double, total: Double)

    var type: String {
        switch self {
        case .photo(_):
            return "photo"
        case .photoCarousel(_):
            return "photo_carousel"
        case .donationProgress(_, _):
            return "donation_progress"
        }
    }
}

extension Media {
    static func createFakePhotoMedia() -> Media {
        Media.photo(photoUrl: "imageUrl")
    }

    static func createFakePhotoCarouselMedia() -> Media {
        Media.photoCarousel(photoUrls: [
            "imageUrl 1",
            "imageUrl 2",
            "imageUrl 3"
        ])
    }

    static func createDonationProgressMedia() -> Media {
        Media.donationProgress(amountRaised: Double.random(in: 0...500), total: Bool.random() ? 800 : 1000)
    }

    static func generateRandomMedia() -> Media {
        [createFakePhotoMedia(),
        createFakePhotoCarouselMedia(),
        createDonationProgressMedia()
        ].randomElement()!
    }
}
