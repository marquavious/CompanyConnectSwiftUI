//
//  CompanyProfileMapView.swift
//  CompanyConnect
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

    let coordinate: Coordinates
    let annotaionUrl: String
    let annotaionName: String
    private let mapCameraBounds = MapCameraBounds(minimumDistance: 4500, maximumDistance: 4500)

    var body: some View {
        Map(
            bounds: mapCameraBounds,
            interactionModes: []
        ) {
            Annotation(annotaionName, coordinate: coordinate.returnCLLocationCoordinate2D()) {
                MapAnnotationView(annotaionUrl: annotaionUrl)
            }
        }
        .frame(height: Constants.Height)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding([.leading, .trailing, .bottom])
        .mapStyle(.hybrid)
    }

}

#Preview {
    CompanyProfileMapView(
        coordinate: Coordinates(latitude: 0, longitude: 0),
        annotaionUrl: "img_url",
        annotaionName: "Annotaion"
    )
}
