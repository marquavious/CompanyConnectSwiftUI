//
//  BriefHistoryImage.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct BriefHistoryImage: Codable {
    let caption: String
    let imageUrl: String
}

extension BriefHistoryImage {
    static func createFakeBriefHistoryImageObject() -> BriefHistoryImage {
        BriefHistoryImage(
            caption: ["Where it all began", "Breaking ground!", "25 Years later..."].randomElement()!,
            imageUrl: "imgurl"
        )
    }
}
