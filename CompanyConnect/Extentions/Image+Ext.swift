//
//  Image+Ext.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/17/24.
//

import Foundation
import SwiftUI

extension Image {

    static func generateRadomImage() -> Image {
        let imagesArray = [
            Image("charleyrivers"),
            Image("chilkoottrail"),
            Image("chincoteague"),
            Image("hiddenlake"),
            Image("icybay"),
            Image("lakemcdonald"),
            Image("rainbowlake"),
            Image("silversalmoncreek"),
            Image("stmarylake"),
            Image("turtlerock"),
            Image("twinlake"),
            Image("umbagog")
        ]

        return imagesArray.randomElement() ?? Image("twinlake")
    }

    static func generateRadomLogo() -> Image {
        let imagesArray = [
            Image(systemName: "car.circle.fill"),
            Image(systemName: "cross.case.circle.fill"),
            Image(systemName: "tree.circle.fill"),
            Image(systemName: "globe.europe.africa.fill"),
            Image(systemName: "eye.circle.fill"),
            Image(systemName: "figure.walk.circle.fill"),
            Image(systemName: "peacesign"),
            Image(systemName: "circle.hexagongrid.fill"),
            Image(systemName: "rotate.3d.fill"),
            Image(systemName: "bird.circle.fill"),
            Image(systemName: "arrow.up.left.arrow.down.right.circle.fill"),
            Image(systemName: "sun.and.horizon.circle.fill")
        ]

        return imagesArray.randomElement() ?? Image(systemName: "cross.case.circle.fill")
    }

}
