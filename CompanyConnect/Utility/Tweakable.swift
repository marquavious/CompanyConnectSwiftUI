//
//  Tweakable.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/28/24.
//

import Foundation

protocol Tweakable: CaseIterable {
    associatedtype T
    var value: T { get }
    var optionDisplayName : String { get }
    static var title: String { get }
    static var key: String { get }
    static var options: [String: String] { get }
}
