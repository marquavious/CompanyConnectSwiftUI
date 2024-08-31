//
//  CompanyVGrid.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct CompanyVGrid: View {

    struct Constants {
        static let cellSize = CGSize(width: 350, height: 150)
        static let edgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        static let bottomContentMarginPadding: CGFloat = 8
    }

    @Binding var shouldShowListView: Bool
    @Binding var inSearchModw: Bool

    var onTapAction: ((Company) -> Void)
    private let vGridColumns = [GridItem(.flexible())]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: vGridColumns) {
                CompanyCardView(
                    cellSize: Constants.cellSize,
                    onTapAction: onTapAction
                )
                .frame(maxHeight: Constants.cellSize.height)
            }
            .padding(Constants.edgeInsets)
        }
        .frame(maxHeight: (shouldShowListView || inSearchModw) ? .infinity : .zero)
        .contentMargins([.bottom], Constants.bottomContentMarginPadding)
        .opacity((shouldShowListView || inSearchModw) ? 1 : 0)
        .animation(.easeInOut, value: (shouldShowListView || inSearchModw))
    }
}

#Preview {
    MapTabView()
}
