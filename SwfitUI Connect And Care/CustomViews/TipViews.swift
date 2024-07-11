//
//  ActivityScrollerTipView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 1/11/24.
//

import Foundation
import TipKit

struct ActivityScrollerTipView: Tip {
    var title: Text {
        Text("Activity Feed")
    }

    var message: Text? {
        Text("Here you will see all updates from diffrent NOG's. Use the filters voice to categorize which posts you see")
    }
}

struct MapTipView: Tip {
    var title: Text {
        Text("Map View")
    }

    var message: Text? {
        Text("Here you will see all locations from different NGOs. Use the list option below to see all of our partners")
    }

    var image: Image? {
        Image(systemName: "globe.americas.fill")
    }
}
