//
//  MapControlPanelView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/11/24.
//

import Foundation
import SwiftUI

struct MapControlPanelView: View {

    @Binding var shouldShowListView: Bool
    @Binding var shouldLockMap: Bool
    let mapTipView = MapTipView()

    @EnvironmentObject var viewModel: NGOMapViewViewModel

    var body: some View {
        HStack {
            Spacer()
            Image(systemName: shouldLockMap ? "dot.scope" : "globe.americas")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(10)
                .background(.regularMaterial)
                .clipShape(Circle())
                .opacity(shouldShowListView ? 0 : 1)
                .onTapGesture {
                    shouldLockMap.toggle()
                }

            Image(systemName: shouldShowListView ? "mappin.and.ellipse" : "list.bullet")
                .frame(width: 20, height: 20)
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
            Image(systemName: "xmark")
                .frame(
                    width: viewModel.hasSelected ? 20 : 0,
                    height: viewModel.hasSelected ? 20 : 0
                )
                .padding(viewModel.hasSelected ? 10 : 0)
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
