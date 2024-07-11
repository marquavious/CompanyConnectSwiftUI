//
//  SwfitUI_Connect_And_CareApp.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/19/23.
//

import SwiftUI
import TipKit

@main
struct SwfitUI_Connect_And_CareApp: App {

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }

    init() {
        try? Tips.resetDatastore() // Purge all TipKit related data.
        try? Tips.configure() // Tips.showTipsForTesting([CompletionToDeleteTip.self])
    }
}

struct MainView: View {
    var body: some View {
        TabView {
            ActivityFeedView().tabItem {
                Label("Feed", systemImage: "bubble.circle.fill")
            }

            NGOMapView().tabItem {
                Label("Map", systemImage: "globe.americas")
            }

            DonationsView().tabItem {
                Label("Donations", systemImage: "dollarsign.circle")
            }
        }
    }
}

#Preview {
    MainView()
}
