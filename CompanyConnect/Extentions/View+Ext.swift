//
//  View+Ext.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 11/22/23.
//

import SwiftUI

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }

}
