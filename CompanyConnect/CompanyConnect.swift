//
//  CompanyConnect.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 11/19/23.
//

import SwiftUI
import TipKit
import Factory
import SwiftData

@main
struct CompanyConnect: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    #if DEBUG
    private let stubsHandler = OHHTTPStubsHandler()
    #endif

    @State private var showingSheet = false
    @StateObject var companyManager: CompanyManager = CompanyManager()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(companyManager)
            .onShake {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                TweakWindowView()
            }
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

struct MainView: View {

    enum TabViewData: String, CaseIterable, Identifiable {
        case feed = "Feed"
        case map = "Map"
        case donations = "Donations"

        var id: String { rawValue }

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

        @ViewBuilder
        func tabView() -> some View {
            switch self {
            case .feed:
                ActivityFeedTabView().tabItem {
                    Label(rawValue, systemImage: systemImageName)
                }
            case .map:
                MapTabView().tabItem {
                    Label(rawValue, systemImage: systemImageName)
                }
            case .donations:
                DonationsView().tabItem {
                    Label(rawValue, systemImage: systemImageName)
                }
            }
        }
    }

    var body: some View {
        TabView {
            ForEach(TabViewData.allCases) { $0.tabView() }
        }
    }
}

struct ConfirmationDialogView: View {
  @State private var showDialog = false

  @State var intColor: Color = .red

  var body: some View {
    HStack {
      Button(action: {
        print("Confirmed")
      }) {
        Text("Yes")
          .frame(maxWidth: .infinity, alignment: .center)
          .foregroundColor(.white)
        //        .padding()
          .padding(7)
          .background(intColor)
          .cornerRadius(8)
//          .frame(maxWidth: .infinity, alignment: .center)
      }
//      .frame(maxWidth: .infinity, alignment: .center)

      Button(action: {

      }) {
        Text("Cancel")
          .frame(maxWidth: .infinity, alignment: .center)
          .foregroundColor(intColor)
          .padding(7)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(intColor, lineWidth: 1)
          )
          .frame(maxWidth: .infinity, alignment: .center)
      }
      .buttonStyle(.plain)
//      .frame(maxWidth: .infinity, alignment: .center)

    }
//    .frame(width: 200, height: 300)
//    .border(.red, width: 1)
  }
}
//
//struct ConfirmationDialogView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConfirmationDialogView()
//    }
//}

#Preview {
  ConfirmationDialogView()
}
