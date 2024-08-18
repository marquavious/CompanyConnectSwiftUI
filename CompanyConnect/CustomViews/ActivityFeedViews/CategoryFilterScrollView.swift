//
//  CategoryFilterScrollView.swift
//  CompanyConnect
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

    @EnvironmentObject var categoryFilter: CategoryManager
    private let gridRows = [GridItem(.flexible())]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridRows) {
                ForEach(categoryFilter.categories) { category in
                    ZStack {
                        ActivityFeedCategoryButtonView(
                            text: category.name,
                            color: category.color,
                            isHighlighted: categoryFilter.selectedCategoriesConatins(category)
                        ) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                categoryFilter.handleCategorySelection(category: category)
                            }
                        }
                        .padding(Constants.edgeInsets)
                    }
                }
            }
        }
        .contentMargins(.horizontal, Constants.Padding)
    }

}
