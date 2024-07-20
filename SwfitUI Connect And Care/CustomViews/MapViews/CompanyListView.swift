//
//  CompanyListView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/12/24.
//

import Foundation
import SwiftUI

struct CompanyListView: View {

    struct Constants {
        static let maxHeight: CGFloat = 235
        static let verticalGridPadding: CGFloat = 16
        static let categoryFilterScrollViewHeight: CGFloat = 50
    }

    @Binding var shouldShowListView: Bool
    var viewModel: MapViewViewModelType

    var didSelectCompany: (CompanyObject) -> Void

    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                CategoryFilterScrollView(viewModel: viewModel) {
                    viewModel.handleSelectedCategory($0)
                }
                .frame(maxHeight: Constants.categoryFilterScrollViewHeight)

                Divider()

                CompanyHGrid(
                    viewModel: viewModel,
                    shouldShowListView: $shouldShowListView
                ){
                    didSelectCompany($0)
                }

                CompanyVGrid(
                    viewModel: viewModel,
                    shouldShowListView: $shouldShowListView
                ){
                    didSelectCompany($0)
                }
                .padding(.bottom, shouldShowListView ? .zero : Constants.verticalGridPadding)
            }
        }
        .frame(maxHeight: shouldShowListView ? .infinity : Constants.maxHeight)
        .background(.regularMaterial)
    }

}

#Preview {
    MapTabView(viewModel: FakeMapViewViewModel())
}
