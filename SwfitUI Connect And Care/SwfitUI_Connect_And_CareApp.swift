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

    let dependencyGraph: DependencyGraph = {
        let configEnvString: String
        do {
            configEnvString = try Configuration.value(for: ConfiKeys.APPLICATION_ENVIRONMENT.rawValue)
        } catch { fatalError("Could not load enviorment variable") }

        if let enviorment = ApplicationEnviorment(rawValue: configEnvString) {
            return DependencyGraph(applicationEnviorment: enviorment)
        } else { fatalError("Could not load enviorment variable") }
    }()

    var body: some Scene {
        WindowGroup {
            MainView(dependencyGraph: dependencyGraph)
        }
    }

    init() {
    #if RELEASE
        try? Tips.resetDatastore() // Purge all TipKit related data.
        try? Tips.configure() // Tips.showTipsForTesting([CompletionToDeleteTip.self])
    #endif
    }   
    
}

struct MainView: View {

    let dependencyGraph: DependencyGraph

    var body: some View {
        TabView {
            ActivityFeedView(viewModel: dependencyGraph.applicationEnviorment.activityFeedViewModel).tabItem {
                Label("Feed", systemImage: "bubble.circle.fill")
            }

            MapTabView(viewModel: dependencyGraph.applicationEnviorment.mapViewViewModel).tabItem {
                Label("Map", systemImage: "globe.americas")
            }

            DonationsView(user: User.createFakeUserData()).tabItem {
                Label("Donations", systemImage: "dollarsign.circle")
            }
        }
    }
}

#Preview {
    MainView(dependencyGraph: DependencyGraph(applicationEnviorment: .offline))
}
