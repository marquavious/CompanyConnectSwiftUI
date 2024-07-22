//
//  BriefHistoryImageObject.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct BriefHistoryImageObject: Codable {
    let caption: String
    let imageUrl: String
}

extension BriefHistoryImageObject {
    static func createFakeBriefHistoryImageObject() -> BriefHistoryImageObject {
        BriefHistoryImageObject(
            caption: ["Where it all began", "Breaking ground!", "25 Years later..."].randomElement()!,
            imageUrl: "imgurl"
        )
    }
}
