//
//  BaseMapView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/14/24.
//

import Foundation
import SwiftUI
import MapKit

struct BaseMapView: View {

    var viewModel: MapViewViewModelType

    // For some strange rason, we cannot force inital max zoom out levels using native maps
    // Unless we introduce SDKs, we will have to deal with this for now. Thanks Apple.
    @State private var defaultMapPosition: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -23.42809276607726, longitude: -67.55868389498802), span: MKCoordinateSpan(latitudeDelta: 200, longitudeDelta: 200)))

    var didSelectCompany: (CompanyObject) -> Void

    var body: some View {
        Map(position: $defaultMapPosition, interactionModes: [.all]) {
            ForEach(viewModel.presentedCompanies()) { company in
                Annotation(
                    company.orginizationName,
                    coordinate: company.coordinate
                ) {
                    MapAnnotationView(company: company)
                        .onTapGesture {
                            didSelectCompany(company)
                        }
                }
            }
        }
    }

}

#Preview {
    MapTabView(viewModel: FakeMapViewViewModel())
}
