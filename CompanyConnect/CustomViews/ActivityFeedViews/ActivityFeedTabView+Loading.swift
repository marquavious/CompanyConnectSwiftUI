//
//  ActivityFeedTabView+Loading.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation

extension ActivityFeedTabView {
    enum LoadingState: Equatable {
        case loading
        case fetched
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
