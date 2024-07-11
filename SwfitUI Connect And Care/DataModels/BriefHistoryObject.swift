//
//  BriefHistoryObject.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation

struct BriefHistoryObject: Hashable, Identifiable {

    let id = UUID()

    let history: String
    let imageObjects: [BriefHistoryImageObject]

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
