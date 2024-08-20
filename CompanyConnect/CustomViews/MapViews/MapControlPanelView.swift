//
//  MapControlPanelView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct MapControlPanelView: View {

    private enum Icons: String {
        case mapLockedIcon = "dot.scope"
        case mapUnlocked = "globe.americas"
        case mapListViewShowed = "mappin.and.ellipse"
        case mapListViewHidden = "list.bullet"
        case clearMapSelection = "xmark"
    }

    private struct Constants {
        static let ButtonSize = CGSize(width: 20, height: 20)
        static let ButtonPadding: CGFloat = 10
        static let AnimationDuration: CGFloat = 0.5
        static let Padding: CGFloat = 8
    }

    @Binding var shouldShowListView: Bool
    @EnvironmentObject var companyFilter: CompanyManager

    private let mapTipView = MapTipView()

    var body: some View {
        HStack {
            Spacer()

            Image(systemName: shouldShowListView ? Icons.mapListViewShowed.rawValue : Icons.mapListViewHidden.rawValue)
                .frame(
                    width: Constants.ButtonSize.width,
                    height: Constants.ButtonSize.height
                )
                .padding(Constants.ButtonPadding)
                .background(.regularMaterial)
                .clipShape(Circle())
                .onTapGesture {
                    mapTipView.invalidate(reason: .actionPerformed)
                    withAnimation(.easeInOut(duration: Constants.AnimationDuration)) {
                        shouldShowListView.toggle()
                    }
                }
                .popoverTip(mapTipView, arrowEdge: .bottom)

            Image(systemName: Icons.clearMapSelection.rawValue)
                .frame(
                    width: companyFilter.categoryFilter.hasSelectedCategories ? Constants.ButtonSize.width : .zero,
                    height: companyFilter.categoryFilter.hasSelectedCategories ? Constants.ButtonSize.height : .zero
                )
                .padding(companyFilter.categoryFilter.hasSelectedCategories ? Constants.ButtonPadding : .zero)
                .foregroundColor(.white)
                .background(.regularMaterial)
                .environment(\.colorScheme, .dark)
                .clipShape(Circle())
                .transition(.scale)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        companyFilter.categoryFilter.resetSelectedCategories()
                    }
                }
        }
        .padding(Constants.Padding)
    }
}

#Preview {
    MapTabView()
}
