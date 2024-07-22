//
//  CompanyConnect.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 11/19/23.
//

import SwiftUI
import TipKit

@main
struct CompanyConnect: App {

    private let dependencyGraph: DependencyGraphType = {
        let configEnvString: String
        do {
            configEnvString = try Configuration.value(for: ConfiKeys.APPLICATION_ENVIRONMENT.rawValue)
        } catch {
            fatalError("Could not load APPLICATION_ENVIRONMENT variable")
        }

        if let enviorment = ApplicationEnviorment(rawValue: configEnvString) {
            switch enviorment {
            case .production:
                return DependencyGraph()
            case .offline:
                return OfflineDependencyGraph()
            case .integrated:
                return IntegratedDependencyGraph()
            case .development:
                return DevlopmentDependencyGraph()
            }
        } else {
            fatalError("Could not crate DependencyGraph from Config.")
        }
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

    let dependencyGraph: DependencyGraphType

    var body: some View {
        TabView {
            ActivityFeedView(viewModel: dependencyGraph.activityFeedViewModel).tabItem {
                Label("Feed", systemImage: "bubble.circle.fill")
            }

            MapTabView(viewModel: dependencyGraph.mapViewViewModel).tabItem {
                Label("Map", systemImage: "globe.americas")
            }

            DonationsView(viewModel: dependencyGraph.donationsViewViewModel).tabItem {
                Label("Donations", systemImage: "dollarsign.circle")
            }
        }
    }
}

#Preview {
    MainView(dependencyGraph: DevlopmentDependencyGraph())
}
