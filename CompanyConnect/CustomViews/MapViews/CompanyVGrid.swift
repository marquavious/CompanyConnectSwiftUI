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

    var viewModel: MapViewViewModelType
    @Binding var shouldShowListView: Bool

    var onTapAction: ((CompanyObject) -> Void)
    private let vGridColumns = [GridItem(.flexible())]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: vGridColumns) {
                CompanyCardView(
                    viewModel: viewModel,
                    onTapAction: onTapAction,
                    cellSize: Constants.cellSize
                )
                .frame(maxHeight: Constants.cellSize.height)
            }
            .padding(Constants.edgeInsets)
        }
        .frame(maxHeight: shouldShowListView ? .infinity : .zero)
        .contentMargins([.bottom], Constants.bottomContentMarginPadding)
        .opacity(shouldShowListView ? 1 : 0)
    }

}

#Preview {
    MapTabView(shouldShowListView: true, viewModel: FakeMapViewViewModel())
}
