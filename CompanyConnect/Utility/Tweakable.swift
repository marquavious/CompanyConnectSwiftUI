//
//  Tweakable.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/28/24.
//

import Foundation

protocol Tweakable: CaseIterable {
    associatedtype T
    func value() -> T
    var displayName: String { get }
    static var tweakWindowName: String { get }
    static var key: String { get }
}
