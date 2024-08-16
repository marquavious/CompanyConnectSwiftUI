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

    @State var shouldShowListView: Bool = false
    @State private var shouldLockMap: Bool = true
    @State private var selectedCompanies = [CompanyObject]()

//    var viewModel: MapViewViewModelType

    @Injected(\.mapViewModel) private var viewModel

    var body: some View {
        NavigationStack(path: $selectedCompanies) {
            switch viewModel.loadingState {
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
                    BaseMapView(viewModel: viewModel) {
                        selectedCompanies.append($0)
                    }

                    VStack(spacing: .zero) {
                        Spacer()
                        MapControlPanelView(
                            shouldShowListView: $shouldShowListView,
                            viewModel: viewModel
                        )

                        CompanyListView(
                            shouldShowListView: $shouldShowListView,
                            viewModel: viewModel)
                        {
                            selectedCompanies.append($0)
                        }
                    }
                }
                .navigationDestination(for: CompanyObject.self) { _ in
                    // CompanyProfileView(viewModel: CompanyProfileViewViewModel(company: $0), companyID: <#String#>)
                }
            case .error:
                // Handle Error
                Text("OOOPS :)")
            }
        }
        .task {
            if viewModel.loadingState != .fetched {
                await fetchMapData()
            }
        }
    }

    private func fetchMapData() async {
        await viewModel.loadMapData()
    }

}

//#Preview {
//    MapTabView(
//        viewModel: DevMapViewViewModel(loadingState: .error(DevError.error)))
//}

enum DevError: Error {
    case error
}
