//
//  CacheDateManager.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/20/24.
//

import Foundation

class CacheDateManager {
    enum Keys: String {
        case companyObjectsLastUpdatedDate = "company_objects_last_updated_date_key"
    }

    static let shared = CacheDateManager()
    private init () { }

    var compnayObjectsHaveExpired: Bool {
        guard let date = UserDefaults.standard.value(forKey: Keys.companyObjectsLastUpdatedDate.rawValue) as? Date else {
            return true
        }

        guard date.daysAgo < 1 else {
            return true
        }

        return false
    }

    func updateLastUpdatedDate(key: Keys) {
        switch key {
        case .companyObjectsLastUpdatedDate:
            UserDefaults.standard.setValue(Date(), forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }

    func clearUpdateLastUpdatedDate(key: Keys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}
