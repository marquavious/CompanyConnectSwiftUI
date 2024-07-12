//
//  IdentifiableImage.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct IdentifiableImage: Identifiable, Hashable {
    let id = UUID()
    let image: Image

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
