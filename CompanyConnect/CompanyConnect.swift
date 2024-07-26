//
//  CompanyConnect.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 11/19/23.
//

import SwiftUI
import TipKit
import OHHTTPStubs
import OHHTTPStubsSwift

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

    private let stubsHandler = OHHTTPStubsHandler()

    var body: some Scene {
        WindowGroup {
            MainView(dependencyGraph: dependencyGraph)
        }
    }

    init() {

    #if DEBUG
        stubsHandler.setupStubs()
    #endif

    #if RELEASE
        try? Tips.resetDatastore() // Purge all TipKit related data.
        try? Tips.configure() // Tips.showTipsForTesting([CompletionToDeleteTip.self])
    #endif
    }
}

class OHHTTPStubsHandler: NSObject {

    func setupStubs() {
        stub(condition: isPath("/activity_feed")) { _ in
            let stubPath = OHPathForFile("ActivityfeedJsonResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        stub(condition: isPath("/mapdata")) { _ in
            let stubPath = OHPathForFile("MapViewJsonResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        stub(condition: isPath("/donations")) { _ in
            let stubPath = OHPathForFile("DonationsViewJsonResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

    }

}

struct MainView: View {

    let dependencyGraph: DependencyGraphType

    enum TabViewData: String {

        case feed = "Feed"
        case map = "Map"
        case donations = "Donations"

        var systemImageName: String {
            switch self {
            case .feed:
                "bubble.circle.fill"
            case .map:
                "globe.americas"
            case .donations:
                "dollarsign.circle"
            }
        }
    }

    var body: some View {
        TabView {
            ActivityFeedView(viewModel: dependencyGraph.activityFeedViewModel).tabItem {
                Label(TabViewData.feed.rawValue, systemImage: TabViewData.feed.systemImageName)
            }

            MapTabView(viewModel: dependencyGraph.mapViewViewModel).tabItem {
                Label(TabViewData.map.rawValue, systemImage: TabViewData.map.systemImageName)
            }

            DonationsView(viewModel: dependencyGraph.donationsViewViewModel).tabItem {
                Label(TabViewData.donations.rawValue, systemImage: TabViewData.donations.systemImageName)
            }
        }
    }
}

#Preview {
    MainView(dependencyGraph: DevlopmentDependencyGraph())
}
