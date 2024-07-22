//
//  MediaData.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation
import SwiftUI

enum MediaData: Codable {
    
    case photo(String)
    case photoCarousel([String])
    case donationProgress(Double, Double)

    var type: String {
        switch self {
        case .photo(_):
            return "photo"
        case .photoCarousel(_):
            return "photos"
        case .donationProgress(_, _):
            return "donationProgress"
        }
    }
}

extension MediaData {
    static func createFakePhotoMedia() -> MediaData {
        MediaData.photo("imageUrl")
    }

    static func createFakePhotoCarouselMedia() -> MediaData {
        MediaData.photoCarousel([
            "imageUrl 1",
            "imageUrl 2",
            "imageUrl 3"
        ])
    }

    static func createDonationProgressMedia() -> MediaData {
        MediaData.donationProgress(Double.random(in: 0...500), Bool.random() ? 800 : 1000)
    }

    static func generateRandomMedia() -> MediaData {
        [createFakePhotoMedia(),
        createFakePhotoCarouselMedia(),
        createDonationProgressMedia()
        ].randomElement()!
    }
}
