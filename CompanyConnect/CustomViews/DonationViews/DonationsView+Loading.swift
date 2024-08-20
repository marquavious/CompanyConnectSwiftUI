//
//  DonationsView+Loading.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation
import SwiftUI

extension DonationsView {

    enum LoadingState: Equatable {
        case loading
        case fetched(past: [Donation], scheduled: [Donation])
        case error(Error)

        static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading), (.fetched, .fetched):
                true
            case let (.error(lhsError), .error(rhsError)):
                lhsError.localizedDescription == rhsError.localizedDescription
            default:
                false
            }
        }
    }
}

#Preview {
    DonationsView()
}
