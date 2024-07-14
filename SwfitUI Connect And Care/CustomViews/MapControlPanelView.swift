//
//  MapControlPanelView.swift
//  SwfitUI Connect And Care
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
        static let Padding: CGFloat = 10
    }

    @Binding var shouldShowListView: Bool
    @Binding var shouldLockMap: Bool
    @EnvironmentObject var viewModel: MapViewViewModel

    private let mapTipView = MapTipView()

    var body: some View {
        HStack {
            Spacer()

            Image(systemName: shouldLockMap ? Icons.mapLockedIcon.rawValue : Icons.mapUnlocked.rawValue)
                .resizable()
                .frame(width: Constants.ButtonSize.width, height: Constants.ButtonSize.height)
                .padding(10)
                .background(.regularMaterial)
                .clipShape(Circle())
                .opacity(shouldShowListView ? 0 : 1)
                .onTapGesture {
                    shouldLockMap.toggle()
                }

            Image(systemName: shouldShowListView ? Icons.mapListViewShowed.rawValue : Icons.mapListViewHidden.rawValue)
                .frame(width: Constants.ButtonSize.width, height: Constants.ButtonSize.height)
                .padding(10)
                .background(.regularMaterial)
                .clipShape(Circle())
                .onTapGesture {
                    mapTipView.invalidate(reason: .actionPerformed)
                    withAnimation(.easeInOut(duration: 0.4)) {
                        shouldShowListView.toggle()
                    }
                }
                .popoverTip(mapTipView, arrowEdge: .bottom)

            Image(systemName: Icons.clearMapSelection.rawValue)
                .frame(
                    width: viewModel.hasSelected ? Constants.ButtonSize.width : .zero,
                    height: viewModel.hasSelected ? Constants.ButtonSize.height : .zero
                )
                .padding(viewModel.hasSelected ? Constants.Padding : .zero)
                .foregroundColor(.white)
                .background(.regularMaterial)
                .environment(\.colorScheme, .dark)
                .clipShape(Circle())
                .transition(.scale)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.selctedCategories = []
                        shouldLockMap = true
                    }
                }
        }
        .padding(8)

    }
}

#Preview {
    MapTabView()
        .environmentObject(MapViewViewModel())
}
