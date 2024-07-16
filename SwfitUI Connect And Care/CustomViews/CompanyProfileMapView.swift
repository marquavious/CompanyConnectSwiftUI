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

    var companyObject: CompanyObject

    var body: some View {
        Map(bounds:
                MapCameraBounds(minimumDistance: 4500,
                                maximumDistance: 4500),
            interactionModes: []) {

            Annotation("", coordinate: companyObject.coordinate) {
                VStack(spacing: 1) {
                    Circle()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Circle()
                                .fill(Color.white)
                                .padding(6)
                        }

                    Triangle()
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 15, height: 10)
                        .rotationEffect(.degrees(180))
                }
            }
        }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding([.leading, .trailing, .bottom])
            .mapStyle(.hybrid)
    }
}
