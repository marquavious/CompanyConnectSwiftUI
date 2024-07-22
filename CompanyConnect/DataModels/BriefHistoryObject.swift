//
//  BriefHistoryObject.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct BriefHistoryObject: Codable {

    let history: String
    let imageObjects: [BriefHistoryImageObject]
}

extension BriefHistoryObject {
    static func createFakeBriefHistoryObject() -> BriefHistoryObject {
        BriefHistoryObject(
            history: StringGenerator.generateLongString(),
            imageObjects: [
                BriefHistoryImageObject.createFakeBriefHistoryImageObject(),
                BriefHistoryImageObject.createFakeBriefHistoryImageObject(),
                BriefHistoryImageObject.createFakeBriefHistoryImageObject()
            ]
        )
    }
}
