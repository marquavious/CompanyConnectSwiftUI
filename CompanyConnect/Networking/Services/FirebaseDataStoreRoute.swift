//
//  FirebaseDataStoreRoute.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/22/24.
//

import Foundation

enum FirebaseDataStoreRoute {
    case companyObjects

    var route: String {
        switch self {
        case .companyObjects:
            return "test_company_objects"
        }
    }
}
