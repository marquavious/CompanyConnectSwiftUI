//
//  BriefHistoryObject.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct BriefHistory: Codable {
    let history: String
    let imageObjects: [BriefHistoryImage]

    enum CodingKeys: String, CodingKey {
        case history
        case imageObjects = "image_objects"
    }
}

extension BriefHistory {
    static func createFakeBriefHistoryObject() -> BriefHistory {
        BriefHistory(
            history: StringGenerator.generateLongString(),
            imageObjects: [
                BriefHistoryImage.createFakeBriefHistoryImageObject(),
                BriefHistoryImage.createFakeBriefHistoryImageObject(),
                BriefHistoryImage.createFakeBriefHistoryImageObject()
            ]
        )
    }
}
