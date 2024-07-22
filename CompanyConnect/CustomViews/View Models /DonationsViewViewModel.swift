//
//  DonationsViewViewModel.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/21/24.
//

import Foundation

protocol DonationsViewViewModelType {
    var user: User { get }
}

@Observable
class DonationsViewViewModel: DonationsViewViewModelType {

    let user: User

    init(user: User) {
        self.user = user
    }
}

@Observable
class DevDonationsViewViewModel: DonationsViewViewModelType {
    let user: User = User.createFakeUserData()
}
