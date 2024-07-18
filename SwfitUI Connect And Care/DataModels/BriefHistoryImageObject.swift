//
//  BriefHistoryImageObject.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct BriefHistoryImageObject: Hashable, Identifiable {

    let id = UUID()
    let caption: String
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension BriefHistoryImageObject {
    static func createFakeBriefHistoryImageObject() -> BriefHistoryImageObject {
        BriefHistoryImageObject(
            caption: ["Where it all began", "Breaking ground!", "25 Years later..."].randomElement()!,
            image: Image.generateRadomImage()
        )
    }
}
