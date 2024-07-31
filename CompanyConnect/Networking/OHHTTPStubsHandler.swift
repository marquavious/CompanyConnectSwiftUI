//
//  OHHTTPStubsHandler.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/26/24.
//

import Foundation
import OHHTTPStubs
import OHHTTPStubsSwift

class OHHTTPStubsHandler: NSObject {

    private let internetResponseTime: TimeInterval = CCTweakManager.shared.retreiveTweakValue(tweak: .internetSpeed).value as! TimeInterval

    func setupStubs() {
        setupActivityfeedStubs()

        stub(condition: isPath("/mapdata")) { [weak self]  _ in
            guard let self else { return HTTPStubsResponse (error: OHHTTPStubsHandlerError.memoryError)}
            let stubPath = OHPathForFile("MapViewJsonResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                .responseTime(
                    internetResponseTime
                )
        }

        stub(condition: isPath("/donations")) { [weak self]  _ in
            guard let self else { return HTTPStubsResponse (error: OHHTTPStubsHandlerError.memoryError)}
            let stubPath = OHPathForFile("DonationsViewJsonResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                .responseTime(
                    internetResponseTime
                )
        }

    }

    func setupActivityfeedStubs() {
        stub(condition: isPath("/activity_feed") && containsQueryParams(["page" : "1"])) { [weak self]  _ in
            guard let self else { return HTTPStubsResponse (error: OHHTTPStubsHandlerError.memoryError)}
            let stubPath = OHPathForFile("ActivityfeedJsonResponsePage1.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                .responseTime(
                    internetResponseTime
                )
        }

        stub(condition: isPath("/activity_feed") && containsQueryParams(["page" : "2"])) { [weak self]  _ in
            guard let self else { return HTTPStubsResponse (error: OHHTTPStubsHandlerError.memoryError)}
            let stubPath = OHPathForFile("ActivityfeedJsonResponsePage2.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                .responseTime(
                    internetResponseTime
                )
        }

        stub(condition: isPath("/activity_feed") && containsQueryParams(["page" : "3"])) { [weak self]  _ in
            guard let self else { return HTTPStubsResponse (error: OHHTTPStubsHandlerError.memoryError)}
            let stubPath = OHPathForFile("ActivityfeedJsonResponsePage3.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                .responseTime(
                    internetResponseTime
                )
        }
    }

}

enum OHHTTPStubsHandlerError: Error {
    case memoryError
}
