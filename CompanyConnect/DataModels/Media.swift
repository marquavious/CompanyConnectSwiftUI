//
//  MediaData.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation
import SwiftUI

struct PhotoCarouselData: Codable, Hashable {
    let index: Int
    let imageUrl: String
}

enum Media: Codable {

    case photo(photoUrl:String)
    case photoCarousel(carousel: [PhotoCarouselData])
    case donationProgress(amountRaised:Double, total: Double)

    var type: String {
        switch self {
        case .photo:
            return "photo"
        case .photoCarousel:
            return "photo_carousel"
        case .donationProgress:
            return "donation_progress"
        }
    }
}

extension Media {
    static func createFakePhotoMedia() -> Media {
        Media.photo(photoUrl: "imageUrl")
    }

    static func createFakePhotoCarouselMedia() -> Media {
        Media.photoCarousel(carousel: [
            PhotoCarouselData(index: 0, imageUrl: "imageUrl 1"),
            PhotoCarouselData(index: 1, imageUrl: "imageUrl 2"),
            PhotoCarouselData(index: 2, imageUrl: "imageUrl 3")
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
