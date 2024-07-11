//
//  CategoryFilterScrollView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct CategoryFilterScrollView: View {

    @EnvironmentObject var viewModel: NGOMapViewViewModel
    var onTapAction: ((Category) -> Void)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(viewModel.categories, id: \.self) { category in
                    ZStack {
                        RoundButtonView(text: category.name, color: category.color, isHighlighted: viewModel.selctedCategories.contains(category))
                            .onTap { _ in
                                onTapAction(category)
                            }
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    }
                }
            }
        }
        .contentMargins(.horizontal, 8)
    }
}
