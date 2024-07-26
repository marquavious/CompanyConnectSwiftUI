//
//  URLBuilder.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/25/24.
//

import Foundation

enum URLBuilder {
    case activityFeed(page: String)
    case mapdata
    case donations(userID: String)

    public var url: URL {
        urlBuilder()
    }

    public var path: String {
        switch self {
        case .activityFeed:
            "/activity_feed"
        case .mapdata:
            "/mapdata"
        case .donations(_):
            "/donations"
        }
    }

    private var baseURL: String {
        do {
            return try Configuration.value(for: ConfiKeys.BASE_URL.rawValue) as String
        } catch {
            fatalError("Could not load BASE_URL variable")
        }
    }

    private var queryItems: [URLQueryItem]? {
        switch self {
        case .activityFeed(page: let page):
            [
                URLQueryItem(name: "page", value: page)
            ]
        case .donations(userID: let userID):
            [
                URLQueryItem(name: "user_id", value: userID)
            ]
        default:
            nil
        }
    }

    private func urlBuilder() -> URL {
        var baseURLComponents = URLComponents()
        baseURLComponents.scheme = "https"
        baseURLComponents.host = baseURL
        baseURLComponents.path = path
        baseURLComponents.queryItems = queryItems

        if let url = baseURLComponents.url?.absoluteURL
        {
            return url
        } else {
            fatalError("Returned invalid URL in URLBuilder")
        }
    }
}
