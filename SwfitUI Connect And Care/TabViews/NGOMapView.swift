//
//  NGOMapView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/29/23.
//

import SwiftUI
import MapKit
import TipKit

struct NGOMapView: View {

    @Environment(\.colorScheme) var colorScheme
    @State var shouldShowListView: Bool = false
    @State var shouldLockMap: Bool = true

    @State private var presentedNgos: [CompanyObject] = []

    @StateObject var viewModel = NGOMapViewViewModel()

    var body: some View {
        NavigationStack(path: $presentedNgos) {
            GeometryReader { proxy in
                ZStack {
                    VStack {
                        Map(interactionModes: shouldLockMap ? [] : [.all]) {
                            ForEach(viewModel.presentedCompanies) { company in
                                Annotation(company.orginizationName, coordinate: company.coordinate) {
                                    ZStack {
                                        VStack(spacing: 1) {
                                            Circle()
                                                .fill(Color.white.opacity(0.7))
                                                .frame(width: 40, height: 40)
                                                .overlay {
                                                    if company.shouldUseSolidColorBackground {
                                                        Circle()
                                                            .fill(company.themeColor)
                                                            .frame(width: 30, height: 30)
                                                            .overlay(alignment: .center) {
                                                                Color.white
                                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                    .mask {
                                                                        VStack(spacing: 0) {
                                                                            Text(Image(systemName: company.logoSystemName))
                                                                                .font(.title2)
                                                                                .bold()
                                                                        }
                                                                    }
                                                            }
                                                    } else {
                                                        company.logo
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 30, height: 30)
                                                            .clipShape(Circle())
                                                            .overlay(alignment: .center) {
                                                                Color.white
                                                                    .mask {
                                                                        VStack(spacing: 0) {
                                                                            Text(Image(systemName: company.logoSystemName))
                                                                                .font(.title2)
                                                                                .bold()
                                                                        }
                                                                    }
                                                            }
                                                            .clipShape(Circle())
                                                    }
                                                }

                                            Triangle()
                                                .fill(Color.white.opacity(0.7))
                                                .frame(width: 15, height: 10)
                                                .rotationEffect(.degrees(180))
                                        }
                                    }.onTapGesture {
                                        presentedNgos.append(company)
                                    }
                                }
                            }
                        }
                        .frame(height: proxy.size.height - 235, alignment: .top)

                        Spacer()
                    }.frame(height: proxy.size.height)
                    VStack(spacing: 0) {
                        Spacer()

                        MapControlPanelView(
                            shouldShowListView: $shouldShowListView,
                            shouldLockMap: $shouldLockMap
                        )

                        ZStack {
                            VStack(spacing: 0) {
                                CategoryFilterScrollView { category in
                                    if viewModel.selctedCategories.contains(category) {
                                        viewModel.selctedCategories.removeAll(where: { $0 == category })
                                    } else if !viewModel.selctedCategories.contains(category) {
                                        viewModel.selctedCategories.append(category)
                                    }
                                }
                                .frame(maxHeight: 50)

                                Divider()

                                CompanyHGrid(
                                    shouldShowListView: $shouldShowListView
                                ){ company in
                                    presentedNgos.append(company)
                                }
                                .padding(.top, shouldShowListView ? 0 : 8)

                                CompanyVGrid(
                                    shouldShowListView: $shouldShowListView
                                ){ company in
                                    presentedNgos.append(company)
                                }
                                .padding(.bottom, shouldShowListView ? 0 : 16)
                            }
                        }
                        .frame(maxHeight: shouldShowListView ? .infinity : 235)
                        .background(.regularMaterial)
                    }
                    .environmentObject(viewModel)
                    .navigationDestination(for: CompanyObject.self) { company in
                        NGOProfileView(companyObject: company)
                            .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
    }
}

#Preview {
    NGOMapView()
}
