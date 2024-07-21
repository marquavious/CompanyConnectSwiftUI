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

    let viewModel: ActivityFeedViewViewModelType
    private let rows = [GridItem(.flexible())]

    var onTapAction: ((Category) -> Void)

    var body: some View {
        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {
            LazyHGrid(rows: rows) {
                ForEach(viewModel.categories()) { category in
                    RoundButtonView(
                        text: category.name,
                        color: category.color,
                        isHighlighted: viewModel.selctedCategories().contains(category)
                    ) {
                        onTapAction(category)
                    }
                }
            }
        }
        .background(.background)
        .contentMargins([.horizontal, .vertical], Constants.contentMargins)
    }

}

#Preview {
    ActivityFeedView(viewModel: FakeHomeTabActivityFeed())
}
