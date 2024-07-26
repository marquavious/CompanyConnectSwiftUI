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

    func setupStubs() {
        stub(condition: isPath("/activity_feed")) { _ in
            let stubPath = OHPathForFile("ActivityfeedJsonResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        stub(condition: isPath("/mapdata")) { _ in
            let stubPath = OHPathForFile("MapViewJsonResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        stub(condition: isPath("/donations")) { _ in
            let stubPath = OHPathForFile("DonationsViewJsonResponse.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

    }

}
