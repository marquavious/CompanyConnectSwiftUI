//
//  FirebaseDataStoreRoute.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/22/24.
//

import Foundation

enum FirebaseDataStoreRoute {
    case companyObjects
    case pastDonations
    case scheduledDonations

    var route: String {
        switch self {
        case .companyObjects:
            return "test_company_objects"
        case .pastDonations:
            return "test_past_donations"
        case .scheduledDonations:
            return "test_scheduled_donations"
        }
    }
}
