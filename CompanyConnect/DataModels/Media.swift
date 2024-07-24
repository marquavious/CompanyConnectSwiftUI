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

    case photo(String)
    case photoCarousel([String])
    case donationProgress(Double, Double)

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
        Media.photo("imageUrl")
    }

    static func createFakePhotoCarouselMedia() -> Media {
        Media.photoCarousel([
            "imageUrl 1",
            "imageUrl 2",
            "imageUrl 3"
        ])
    }

    static func createDonationProgressMedia() -> Media {
        Media.donationProgress(Double.random(in: 0...500), Bool.random() ? 800 : 1000)
    }

    static func generateRandomMedia() -> Media {
        [createFakePhotoMedia(),
        createFakePhotoCarouselMedia(),
        createDonationProgressMedia()
        ].randomElement()!
    }
}
