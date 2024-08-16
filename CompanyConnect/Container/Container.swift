//
//  Container.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/15/24.
//

import Foundation
import Factory

extension Container {
    var mapViewModel: Factory<MapViewViewModelType> {
        self { DevMapViewViewModel() }
    }
}
