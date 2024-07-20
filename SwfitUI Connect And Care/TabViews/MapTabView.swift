//
//  NGOMapView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/29/23.
//

import SwiftUI
import MapKit
import TipKit

struct MapTabView: View {

    @State var shouldShowListView: Bool = false
    @State private var shouldLockMap: Bool = true
    @State private var selectedCompanies = [CompanyObject]()
    var viewModel: MapViewViewModelType

    var body: some View {
        NavigationStack(path: $selectedCompanies) {
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

                    CompanyListView(shouldShowListView: $shouldShowListView, viewModel: viewModel) {
                        selectedCompanies.append($0)
                    }
                }
            }
            .navigationDestination(for: CompanyObject.self) {
                CompanyProfileView(companyObject: $0)
            }
        }
    }

}

#Preview {
    MapTabView(viewModel: FakeMapViewViewModel())
}
