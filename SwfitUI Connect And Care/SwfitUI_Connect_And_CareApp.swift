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

    let dependencyGraph = DependencyGraph(applicationBuild: .offline) // CHANGE THIS WITH SCHEMES

    var body: some Scene {
        WindowGroup {
            MainView(dependencyGraph: dependencyGraph)
        }
    }

    init() {
        /*
        try? Tips.resetDatastore() // Purge all TipKit related data.
        try? Tips.configure() // Tips.showTipsForTesting([CompletionToDeleteTip.self])
        */
    }
}

struct MainView: View {

    let dependencyGraph: DependencyGraph

    var body: some View {
        TabView {
            ActivityFeedView(viewModel: dependencyGraph.applicationBuild.activityFeedViewModel).tabItem {
                Label("Feed", systemImage: "bubble.circle.fill")
            }

            MapTabView().tabItem {
                Label("Map", systemImage: "globe.americas")
            }

            DonationsView(user: User.createFakeUserData()).tabItem {
                Label("Donations", systemImage: "dollarsign.circle")
            }
        }
    }
}

#Preview {
    MainView(dependencyGraph: DependencyGraph(applicationBuild: .offline))
}

enum ApplicationBuild {
    case production, debug, offline

    var activityFeedViewModel: ActivityFeedViewViewModelType {
        switch self {
        case .production:
            FakeHomeTabActivityFeed() // For Now
        case .debug:
            FakeHomeTabActivityFeed()
        case .offline:
            StubbedActivityFeed(service: OfflinePostsService(postCount: 50))
        }
    }
}


class DependencyGraph {
    let applicationBuild: ApplicationBuild

    init(applicationBuild: ApplicationBuild) {
        self.applicationBuild = applicationBuild
    }
}
