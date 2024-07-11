//
//  CompanyVGrid.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct CompanyVGrid: View {
    @EnvironmentObject var viewModel: NGOMapViewViewModel
    @Binding var shouldShowListView: Bool
    var onTapAction: ((CompanyObject) -> Void)

    let cellSize = CGSize(width: 350, height: 150)

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    CompanyCardView(onTapAction: onTapAction, cellSize: cellSize)
                        .frame(maxHeight: cellSize.height)
                }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
            }
            .frame(maxHeight: shouldShowListView ? .infinity : 0)
            .contentMargins([.bottom], 8)
            .opacity(shouldShowListView ? 1 : 0)
        }
    }
}

extension CompanyVGrid {
    func onTap(_ handler: @escaping (CompanyObject) -> Void) -> CompanyVGrid {
        var new = self
        new.onTapAction = handler
        return new
    }
}
