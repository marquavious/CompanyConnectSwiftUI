//
//  CompanyHGrid.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct CompanyHGrid: View {
    @EnvironmentObject var viewModel: MapViewViewModel
    @Environment(\.colorScheme) var colorScheme
    @Binding var shouldShowListView: Bool
    var onTapAction: ((CompanyObject) -> Void)

    let cellSize = CGSize(width: 350, height: 150)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(viewModel.presentedCompanies) { company in
                    CompanyCardView(onTapAction: onTapAction, cellSize: cellSize)
                        .frame(maxWidth: cellSize.width, maxHeight: cellSize.height)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 8)
        .frame(maxHeight: shouldShowListView ? 0 : 230)
        .opacity(shouldShowListView ? 0 : 1)

    }
}


extension CompanyHGrid {
    func onTap(_ handler: @escaping (CompanyObject) -> Void) -> CompanyHGrid {
        var new = self
        new.onTapAction = handler
        return new
    }
}

