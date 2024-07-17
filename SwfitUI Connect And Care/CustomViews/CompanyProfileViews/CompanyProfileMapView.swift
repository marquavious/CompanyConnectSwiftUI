//
//  CompanyProfileMapView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI
import MapKit
struct CompanyProfileMapView: View {

    struct Constants {
        static let AnnotationSize: CGSize = CGSize(width: 40, height: 40)
        static let Height: CGFloat = 200
    }

    let company: CompanyObject
    private let mapCameraBounds = MapCameraBounds(minimumDistance: 4500, maximumDistance: 4500)

    var body: some View {
        Map(
            bounds: mapCameraBounds,
            interactionModes: []
        ) {
            Annotation(company.orginizationName, coordinate: company.coordinate) {
                MapAnnotationView(company: company)
            }
        }
        .frame(height: Constants.Height)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding([.leading, .trailing, .bottom])
        .mapStyle(.hybrid)
    }

}

#Preview {
    NGOProfileView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
