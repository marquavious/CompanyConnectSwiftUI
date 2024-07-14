//
//  CategoryFilterScrollView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct CategoryFilterScrollView: View {

    struct Constants {
        static let Padding: CGFloat = 8
        static let edgeInsets = EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
    }

    @EnvironmentObject var viewModel: MapViewViewModel

    var didSelectCategory: ((Category) -> Void)
    private let gridRows = [GridItem(.flexible())]

    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            LazyHGrid(rows: gridRows) {
                ForEach(viewModel.categories) { category in
                    ZStack {
                        RoundButtonView(
                            text: category.name,
                            color: category.color,
                            isHighlighted: viewModel.selctedCategories.contains(category)
                        ) {
                            didSelectCategory(category)
                        }
                        .padding(Constants.edgeInsets)
                    }
                }
            }
        }
        .contentMargins(.horizontal, Constants.Padding)
    }
}
