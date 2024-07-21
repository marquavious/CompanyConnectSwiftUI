//
//  MediaData.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation
import SwiftUI

enum MediaData {
    
    case photo(IdentifiableImage)
    case photoCarousel([IdentifiableImage])
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
        MediaData.photo(IdentifiableImage(image: Image.generateRadomImage()))
    }

    static func createFakePhotoCarouselMedia() -> MediaData {
        MediaData.photoCarousel([
            IdentifiableImage(image: Image.generateRadomImage()),
            IdentifiableImage(image: Image.generateRadomImage()),
            IdentifiableImage(image: Image.generateRadomImage())
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
