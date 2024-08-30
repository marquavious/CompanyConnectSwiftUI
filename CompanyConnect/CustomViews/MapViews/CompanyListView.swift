//
//  CompanyListView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/12/24.
//

import Foundation
import SwiftUI

struct CompanyListView: View {

    struct Constants {
        static let maxHeight: CGFloat = 285
        static let verticalGridPadding: CGFloat = 16
        static let categoryFilterScrollViewHeight: CGFloat = 42
    }

    @Binding var shouldShowListView: Bool
    @EnvironmentObject var companyFilter: CompanyManager

    @State private var searchText: String = ""
    @Environment(\.colorScheme) var colorScheme

    var didSelectCompany: (Company) -> Void

    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(colorScheme == .light ? .white : .gray.opacity(0.3))
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray.opacity(0.6))
                            TextField("Search Companies", text: $searchText)
                        }
                        .shadow(radius: colorScheme == .light ? 1 : 0)
                        .padding([.horizontal], 8)
                    }.padding([.vertical], 8)

                    if companyFilter.categoryFilter.hasSelectedCategories {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                companyFilter.categoryFilter.resetSelectedCategories()
                            }
                        } label: {
                            Rectangle()
                                .fill(colorScheme == .light ? .white : .clear)
                                .frame(width: 34, height: 34)
                                .background(colorScheme == .light ? .white : .gray.opacity(0.3))
                                .cornerRadius(8)
                                .shadow(radius: colorScheme == .light ? 1 : 0)
                        }
                        .overlay {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .imageScale(.large)
                                .overlay {
                                    Image(systemName: "line.diagonal")
                                        .rotationEffect(.degrees(90))
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            shouldShowListView.toggle()
                        }
                    } label: {
                       Rectangle()
                            .fill(colorScheme == .light ? .white : .clear)
                        .frame(width: 34, height: 34)
                        .background(colorScheme == .light ? .white : .gray.opacity(0.3))
                        .cornerRadius(8)
                        .shadow(radius: colorScheme == .light ? 1 : 0)
                    }
                    .overlay {
                        Image(systemName: shouldShowListView ?  "globe.americas" : "list.bullet")
                            .imageScale(.large)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(maxHeight: 50)
                .padding([.horizontal], 8)

                CategoryFilterScrollView()
                    .environmentObject(companyFilter.categoryFilter)
                    .frame(maxHeight: Constants.categoryFilterScrollViewHeight)

                Divider()

                CompanyHGrid(
                    shouldShowListView: $shouldShowListView
                ){
                    didSelectCompany($0)
                }

                CompanyVGrid(
                    shouldShowListView: $shouldShowListView
                ){
                    didSelectCompany($0)
                }
                .padding(.bottom, shouldShowListView ? .zero : Constants.verticalGridPadding)
            }
        }
        .frame(maxHeight: shouldShowListView ? .infinity : Constants.maxHeight)
        .background(.regularMaterial)
        .animation(.easeInOut, value: shouldShowListView)
    }
}

#Preview {
    MapTabView()
        .environmentObject(CompanyManager())
}
