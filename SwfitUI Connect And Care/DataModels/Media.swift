//
//  Media.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation

enum Media {
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
