//
//  CompanyHGrid.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct CompanyHGrid: View {

    struct Constants {
        static let maxHeight: CGFloat = 230
        static let cellSize = CGSize(width: 350, height: 150)
        static let contentMarginHorizontalPadding: CGFloat = 8
        static let bottomContentMarginPadding: CGFloat = 8
    }

    @Binding var shouldShowListView: Bool

    var onTapAction: ((Company) -> Void)
    private let hRowColumns = [GridItem(.flexible())]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: hRowColumns) {
                CompanyCardView(
                    cellSize: Constants.cellSize,
                    onTapAction: onTapAction
                )
                .frame(
                    maxWidth: Constants.cellSize.width,
                    maxHeight: Constants.cellSize.height
                )
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, Constants.contentMarginHorizontalPadding)
        .frame(maxHeight: shouldShowListView ? .zero : Constants.maxHeight)
        .opacity(shouldShowListView ? 0 : 1)
        .animation(.easeInOut, value: shouldShowListView)
    }
}

#Preview {
    MapTabView()
        .environmentObject(CompanyManager())
}
