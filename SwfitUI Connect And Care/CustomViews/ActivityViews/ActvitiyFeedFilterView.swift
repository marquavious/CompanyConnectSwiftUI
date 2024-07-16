//
//  File.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/16/24.
//

import Foundation
import SwiftUI

struct ActvitiyFeedFilterView: View {

    struct Constants {
        static let contentMargins: EdgeInsets = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
    }

    var viewModel: ActivityFeedViewViewModelType
    var onTapAction: ((Category) -> Void)
    private let rows = [GridItem(.flexible())]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
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
    ActivityFeedView(viewModel: BasicFakeActivityFeed())
}
