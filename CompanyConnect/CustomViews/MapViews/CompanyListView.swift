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
        static let maxHeight: CGFloat = 270
        static let verticalGridPadding: CGFloat = 16
        static let categoryFilterScrollViewHeight: CGFloat = 42
    }

    enum Field: Int, Hashable {
        case search
    }

    @Binding var shouldShowListView: Bool
    @EnvironmentObject var companyFilter: CompanyManager
    @State private var isEditing = false

    @State private var searchText: String = ""
    @FocusState private var focusField: Field?
    @State var isFocused: Bool = false
    @Environment(\.colorScheme) var colorScheme

    var didSelectCompany: (Company) -> Void

    var body: some View {
        ZStack {
            VStack(spacing: .zero) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(colorScheme == .light ? .white : .gray.opacity(0.3))
                            .shadow(radius: colorScheme == .light ? 1 : 0)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray.opacity(0.6))
                            TextField("Search Companies", text: $searchText)
                                .toolbar {
                                    ToolbarItemGroup (placement: .keyboard) {
                                        Button {
                                            searchText = ""
                                            isEditing = false
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                        } label: {
                                            Text("RUN")
                                        }
                                    }
                                }
                                .overlay(
                                    Image (systemName: "xmark.circle.fill")
                                        .padding ()
                                        .offset(x: 10)
                                        .foregroundColor(.gray.opacity(0.6))
                                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                                        .onTapGesture {
                                            searchText = ""
                                            isEditing = false
                                        }, alignment: .trailing)
                        }
                        .padding([.horizontal], 8)
                        .onTapGesture {
                            isEditing = true
                        }
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

                    if !isEditing {

                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if shouldShowListView == true, isEditing == true {
                                    isEditing = false
                                } else if shouldShowListView == true, isEditing == false {
                                    shouldShowListView = false
                                    isEditing = false
                                } else if shouldShowListView == false {
                                    shouldShowListView = true
                                    isEditing = false
                                }
                            }
                            searchText = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        } label: {
                            Rectangle()
                                .fill(colorScheme == .light ? .white : .clear)
                                .frame(width: 34, height: 34)
                                .background(colorScheme == .light ? .white : .gray.opacity(0.3))
                                .cornerRadius(8)
                                .shadow(radius: colorScheme == .light ? 1 : 0)
                        }
                        .overlay {
                            if isEditing {
                                Image(systemName: "x.circle")
                                    .imageScale(.large)
                            } else {
                                Image(systemName: (shouldShowListView || isEditing) ?  "globe.americas" : "list.bullet")
                                    .imageScale(.large)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                }
                .frame(maxHeight: 50)
                .padding([.horizontal], 8)
                .padding([.vertical], 4)

                CategoryFilterScrollView()
                    .environmentObject(companyFilter.categoryFilter)
                    .frame(maxHeight: Constants.categoryFilterScrollViewHeight)

                CompanyHGrid(
                    shouldShowListView: $shouldShowListView, 
                    inSearchModw: $isEditing
                ){
                    didSelectCompany($0)
                }

                CompanyVGrid(
                    shouldShowListView: $shouldShowListView, 
                    inSearchModw: $isEditing
                ){
                    didSelectCompany($0)
                }
                .padding(.bottom, (shouldShowListView || isEditing) ? .zero : Constants.verticalGridPadding)
            }
        }
        .frame(maxHeight: (shouldShowListView || isEditing) ? .infinity : Constants.maxHeight)
        .background(.regularMaterial)
        .animation(.easeInOut, value: (shouldShowListView || isEditing))
    }
}

#Preview {
    MapTabView()
        .environmentObject(CompanyManager())
}
