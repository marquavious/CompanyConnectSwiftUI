//
//  CompanyProfileViewViewModelType.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/3/24.
//

import Foundation

protocol CompanyProfileViewViewModelType {
    var bio: String { get set }
    var team: [TeamMember] { get set }
    var projects: [Project] { get set }
    var logoImageUrl: String { get set }
    var coverImageUrl: String { get set }
    var coordinates: Coordinates { get set }
    var missionStatement: String { get set }
    var orginizationName: String { get set }
    var briefHistoryObject: BriefHistoryObject { get set }
    var activityFeedViewModel: ActivityFeedViewViewModelType { get set }
}

class DevCompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var bio: String
    var team: [TeamMember]
    var projects: [Project]
    var logoImageUrl: String
    var coverImageUrl: String
    var coordinates: Coordinates
    var missionStatement: String
    var orginizationName: String
    var briefHistoryObject: BriefHistoryObject
    var activityFeedViewModel: ActivityFeedViewViewModelType

    init(
        bio: String,
        team: [TeamMember],
        projects: [Project],
        logoImageUrl: String,
        coverImageUrl: String,
        coordinates: Coordinates,
        missionStatement: String,
        orginizationName: String,
        briefHistoryObject: BriefHistoryObject,
        activityFeedViewModel: ActivityFeedViewViewModelType)
    {
        self.bio = bio
        self.team = team
        self.projects = projects
        self.logoImageUrl = logoImageUrl
        self.coverImageUrl = coverImageUrl
        self.coordinates = coordinates
        self.missionStatement = missionStatement
        self.orginizationName = orginizationName
        self.briefHistoryObject = briefHistoryObject
        self.activityFeedViewModel = activityFeedViewModel
    }

    convenience init(company: CompanyObject) {
        let company: CompanyObject = CompanyObject.createFakeCompanyObject()
        let activityFeedViewModel = DevCompanyActivityFeed()
        self.init(
            bio: company.bio,
            team: company.team,
            projects: company.projects,
            logoImageUrl: company.logoImageUrl,
            coverImageUrl: company.coverImageUrl,
            coordinates: company.coordinates,
            missionStatement: company.missionStatement,
            orginizationName: company.orginizationName,
            briefHistoryObject: company.briefHistoryObject,
            activityFeedViewModel: activityFeedViewModel
        )
    }

}

class CompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var bio: String = ""
    var team: [TeamMember] = []
    var projects: [Project] = []
    var logoImageUrl: String = ""
    var coverImageUrl: String = ""
    var coordinates: Coordinates = Coordinates(latitude: 0, longitude: 0)
    var missionStatement: String = ""
    var orginizationName: String = ""
    var briefHistoryObject: BriefHistoryObject = BriefHistoryObject(history: "", imageObjects: [])
    var activityFeedViewModel: ActivityFeedViewViewModelType

    init(companyID: String) {
        self.activityFeedViewModel = CompanyActivityFeed(
            companyID: companyID,
            service: ActivityPostsService()
        )
    }

    convenience init(company: CompanyObject) {
        self.init(companyID: company.id)
        self.bio = company.bio
        self.team = company.team
        self.projects = company.projects
        self.logoImageUrl = company.logoImageUrl
        self.coverImageUrl = company.coverImageUrl
        self.coordinates = company.coordinates
        self.missionStatement = company.missionStatement
        self.orginizationName = company.orginizationName
        self.briefHistoryObject = company.briefHistoryObject
        self.activityFeedViewModel = CompanyActivityFeed(
            companyID: company.id,
            service: ActivityPostsService()
        )
    }
}

class OfflineCompanyProfileViewViewModel: CompanyProfileViewViewModelType {
    var bio: String = ""
    var team: [TeamMember] = []
    var projects: [Project] = []
    var logoImageUrl: String = ""
    var coverImageUrl: String = ""
    var coordinates: Coordinates = Coordinates(latitude: 0, longitude: 0)
    var missionStatement: String = ""
    var orginizationName: String = ""
    var briefHistoryObject: BriefHistoryObject = BriefHistoryObject(history: "", imageObjects: [])
    var activityFeedViewModel: ActivityFeedViewViewModelType
    var companyProfileViewService = OfflineCompanyProfileViewService()

    init(companyID: String) {
        self.activityFeedViewModel = CompanyActivityFeed(
            companyID: companyID,
            service: OfflineActivityPostsService()
        )
    }
}
