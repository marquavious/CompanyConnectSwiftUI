//
//  Tweakable.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/28/24.
//

import Foundation

protocol Tweakable {
    associatedtype T
    func value() -> T
    static var key: String { get }
}
