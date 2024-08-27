//
//  URLBuilder.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/25/24.
//

import Foundation

enum URLBuilder {
    case activityFeed(page: Int)
    case mapdata
    case donations(userID: String)
    case companyProfile(companyID: String)
    case companyFeed(companyID: String)

    public var url: URL {
        urlBuilder()
    }

    private var baseURL: String {
        do {
            return try Configuration.value(for: ConfiKeys.BASE_URL.rawValue) as String
        } catch {
            fatalError("Could not load BASE_URL variable")
        }
    }

    public var path: String {
        switch self {
        case .activityFeed:
            "/activity_feed"
        case .mapdata:
            "/mapdata"
        case .donations:
            "/donations"
        case .companyProfile:
            "/company_profile"
        case .companyFeed:
            "/company_feed"
        }
    }

    private var queryItems: [URLQueryItem]? {
        switch self {
        case .activityFeed(page: let page):
            [
                URLQueryItem(name: "page", value: String(page))
            ]
        case .donations(userID: let userID):
            [
                URLQueryItem(name: "user_id", value: userID)
            ]
        case .companyProfile(companyID: let companyID):
            [
                URLQueryItem(name: "company_id", value: companyID)
            ]
        case .companyFeed(companyID: let companyID):
            [
                URLQueryItem(name: "company_id", value: companyID)
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
