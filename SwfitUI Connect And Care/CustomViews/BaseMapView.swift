//
//  BaseMapView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/14/24.
//

import Foundation
import SwiftUI
import MapKit

struct BaseMapView: View {

    @Binding var shouldLockMap: Bool
    @EnvironmentObject var viewModel: MapViewViewModel

    var didSelectCompany: (CompanyObject) -> Void

    var body: some View {
        Map(interactionModes: shouldLockMap ? [] : [.all]) {
            ForEach(viewModel.presentedCompanies) { company in
                Annotation(company.orginizationName, coordinate: company.coordinate) {
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
    MapTabView()
        .environmentObject(MapViewViewModel())
}
