//
//  NGOMapView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 11/29/23.
//

import SwiftUI
import MapKit
import TipKit
import Factory
import SwiftData

struct MapTabView: View {
    @State var shouldShowListView: Bool = false
    @State private var shouldLockMap: Bool = true
    @State private var navigationPath = [Company]()
    @State private var loadingState: LoadingState = .loading

    @EnvironmentObject var companyManager: CompanyManager

    @Injected(\.mapService) private var mapService

    var body: some View {
        NavigationStack(path: $navigationPath) {
            switch loadingState {
            case .loading:
                BasicLoadingView(
                    titleString: "Loading Map Data...",
                    background: Rectangle().fill(.background).background(Map())
                ).task {
                    await loadMapData()
                }
            case .fetched:
                ZStack {
                    BaseMapView() {
                        navigationPath.append($0)
                    }

                    VStack(spacing: .zero) {
                        Spacer()
                        MapControlPanelView(shouldShowListView: $shouldShowListView)

                        CompanyListView(shouldShowListView: $shouldShowListView) {
                            navigationPath.append($0)
                        }
                    }
                }
                .environmentObject(companyManager)
                .navigationDestination(for: Company.self) {
                    CompanyProfileView(companyObject: $0)
                }
            case .error(let error):
                BasicErrorView(
                    errorString: error.localizedDescription,
                    background: Rectangle().fill(.background)
                ) {
                    Task { await loadMapData() }
                }
            }
        }
    }

    private func loadMapData() async {
        loadingState = .loading

        do {
            let mapViewJSONResponse = try await mapService.getMapData()
            companyManager.setCompanies(companies: mapViewJSONResponse.companyObjects)
            loadingState = .fetched
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
                nsError.code == NSURLErrorCancelled {
                //Handle cancellation
            } else {
                loadingState = .error(error)
            }
        }
    }
}

#Preview {
    MapTabView()
}

enum DevError: Error {
    case error
}
