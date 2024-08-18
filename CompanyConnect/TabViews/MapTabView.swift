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

struct MapTabView: View {

    enum LoadingState: Equatable {

        case loading
        case fetched
        case error(Error)

        static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading), (.fetched, .fetched):
                true
            case let (.error(lhsError), .error(rhsError)):
                lhsError.localizedDescription == rhsError.localizedDescription
            default:
                false
            }
        }
    }

    @State var shouldShowListView: Bool = false
    @State private var shouldLockMap: Bool = true
    @State private var selectedCompanies = [CompanyObject]()
    @State private var loadingState: LoadingState = .loading
    @StateObject var companyFilter: CompanyFilter = CompanyFilter()
    @Injected(\.mapService) private var mapService

    var body: some View {
        NavigationStack(path: $selectedCompanies) {
            switch loadingState {
            case .loading:
                Map().overlay(alignment: .center) {
                    Rectangle()
                        .fill(.background)
                        .ignoresSafeArea()
                        .opacity(0.9)
                    VStack(spacing: 0) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 50, height: 50)
                        Text("Loading Map Data...")
                            .foregroundColor(.gray)
                    }
                }
            case .fetched:
                ZStack {
                    BaseMapView() {
                        selectedCompanies.append($0)
                    }

                    VStack(spacing: .zero) {
                        Spacer()
                        MapControlPanelView(shouldShowListView: $shouldShowListView)

                        CompanyListView(shouldShowListView: $shouldShowListView)
                        {
                            selectedCompanies.append($0)
                        }
                    }
                }
                .environmentObject(companyFilter)
                .navigationDestination(for: CompanyObject.self) { _ in
                    // CompanyProfileView(viewModel: CompanyProfileViewViewModel(company: $0), companyID: <#String#>)
                }
            case .error:
                // Handle Error
                Text("OOOPS :)")
            }
        }
        .task {
            if loadingState != .fetched {
                await loadMapData()
            }
        }
    }

    private func loadMapData() async {
        loadingState = .loading
        do {
            let mapViewJSONResponse = try await mapService.getMapData()
            companyFilter.addCompanies(companies: mapViewJSONResponse.companyObjects)
            loadingState = .fetched
        } catch {
            let nsError = error as NSError
            if nsError.domain == NSURLErrorDomain,
                nsError.code == NSURLErrorCancelled {
                //Handle cancellation
            } else {
                //Handle failure
                loadingState = .error(error)
            }
        }
    }

}
