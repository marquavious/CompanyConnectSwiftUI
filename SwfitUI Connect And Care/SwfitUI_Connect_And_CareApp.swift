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

    #if RELEASE
    let dependencyGraph = DependencyGraph(applicationBuild: .production)
    #elseif OFFLINE
    let dependencyGraph = DependencyGraph(applicationBuild: .offline)
    #elseif INTEGRATED
    let dependencyGraph = DependencyGraph(applicationBuild: .integrated)
    #endif

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
            ActivityFeedView(viewModel: dependencyGraph.applicationBuild.activityFeedViewModel).tabItem {
                Label("Feed", systemImage: "bubble.circle.fill")
            }

            MapTabView(viewModel: dependencyGraph.applicationBuild.mapViewViewModel).tabItem {
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
    case production, offline, integrated

    var activityFeedViewModel: ActivityFeedViewViewModelType {
        switch self {
        case .production:
            FakeHomeTabActivityFeed() // For Now
        case .offline:
            StubbedActivityFeed(service: OfflinePostsService(postCount: 50))
        case .integrated:
            StubbedActivityFeed(service: OfflinePostsService(postCount: 50))
        }
    }

    var mapViewViewModel: MapViewViewModelType {
        switch self {
        case .production:
            OfflineMapViewViewModel(mapServiceType: OfflineMapService()) // For Now
        case .offline:
            OfflineMapViewViewModel(mapServiceType: OfflineMapService())
        case .integrated:
            OfflineMapViewViewModel(mapServiceType: OfflineMapService())
        }
    }
}


class DependencyGraph {
    let applicationBuild: ApplicationBuild

    init(applicationBuild: ApplicationBuild) {
        self.applicationBuild = applicationBuild
    }
}
