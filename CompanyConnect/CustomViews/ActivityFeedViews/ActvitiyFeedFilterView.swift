//
//  ActvitiyFeedFilterView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/16/24.
//

import Foundation
import SwiftUI

struct ActvitiyFeedFilterView: View {

    struct Constants {
        static let contentMargins: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    }

    @EnvironmentObject var categoryHandler: CategoryManager

    private let rows = [GridItem(.flexible())]
    var onTapAction: ((Category) -> Void)

    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            LazyHGrid(rows: rows) {
                ForEach(categoryHandler.categories) { category in
                    ActivityFeedCategoryButtonView(
                        text: category.name,
                        color: category.color,
                        isHighlighted: categoryHandler.selctedCategories.contains(category)
                    ) {
                        onTapAction(category)
                    }
                }
            }
        }
        .contentMargins([.horizontal, .vertical], Constants.contentMargins)
    }
}

#Preview {
    ActivityFeedTabView()
}
