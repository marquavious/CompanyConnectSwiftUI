//
//  NGOMapView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/29/23.
//

import SwiftUI
import MapKit

struct CompanyObject: Identifiable, Hashable {
    let id = UUID()
    let orginizationName: String
    let coordinate: CLLocationCoordinate2D

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    public static func == (lhs: CompanyObject, rhs: CompanyObject) -> Bool {
        return lhs.id == rhs.id
    }
}

struct NGOMapView: View {
    @State var shouldShowListView: Bool = false
    @State var shouldShowCategoryClearButton: Bool = false

    var companies: [CompanyObject] = [
        CompanyObject(
            orginizationName: "Cars for Kids 1",
            coordinate: CLLocationCoordinate2D(
                latitude: 18.542952, longitude: -72.39234
            )
        ),
        CompanyObject(
            orginizationName: "Cars for Kids 2",
            coordinate: CLLocationCoordinate2D(
                latitude: -22.859839, longitude: -43.267511
            )
        ),
        CompanyObject(
            orginizationName: "Cars for Kids 3",
            coordinate: CLLocationCoordinate2D(
                latitude: 30.053881, longitude: 31.238474
            )
        ),
        CompanyObject(
            orginizationName: "Cars for Kids 4",
            coordinate: CLLocationCoordinate2D(
                latitude: 31.771959, longitude: 35.217018
            )
        ),
        CompanyObject(
            orginizationName: "Cars for Kids 5",
            coordinate: CLLocationCoordinate2D(
                latitude: 41.9001, longitude: -71.0898
            )
        ),
        CompanyObject(
            orginizationName: "Cars for Kids 6",
            coordinate: CLLocationCoordinate2D(
                latitude: 43.84864, longitude: 18.35644
            )
        )
    ]

    let categories = [
        Category(name: "Health Care", color: .red),
        Category(name: "Women's Advancement", color: .teal),
        Category(name: "Human Rights", color: .purple),
        Category(name: "Environmental Issues", color: .mint),
        Category(name: "Community Building", color: .green),
        Category(name: "Conflict Relief", color: .pink),
        Category(name: "Veterans", color: .orange),
        Category(name: "Education", color: .blue),
        Category(name: "Indigenous Rights", color: .yellow)
    ]

    var body: some View {
        ZStack {
            Map {
                ForEach(companies) { company in
                    Marker(company.orginizationName, coordinate: company.coordinate)
                }
            }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: shouldShowListView ? "mappin.and.ellipse" : "list.bullet")
//                      .resizable()
                      .frame(width: 25, height: shouldShowListView ? 25 : 15)
                      .padding(15)
                      .background(Color.white.opacity(0.9))
                      .clipShape(Circle())
                      .onTapGesture {
                          withAnimation {
                              shouldShowListView.toggle()
                          }
                      }

                    Image(systemName: "xmark")
//                      .resizable()
                      .frame(
                        width: shouldShowCategoryClearButton ? 25 : 0,
                        height: shouldShowCategoryClearButton ? 25 : 0
                      )
                      .padding(shouldShowCategoryClearButton ? 15 : 0)
                      .foregroundColor(.white)
                      .background(Color.black.opacity(0.7))
                      .clipShape(Circle())
                      .transition(.scale)
                      .onTapGesture {
                          withAnimation {
                              print("FF")
                              shouldShowCategoryClearButton.toggle()
                          }
                          // Clear

                      }

                }.padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: shouldShowListView ? 16 : 8))


                ZStack {
                    VStack(spacing: 0) {

                    CategoryFilterScrollViewTwo(categories: categories)
                       Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(height: 0.7)
                            .shadow(radius: 1, y: 1)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem(.flexible())]) {
                                ForEach(companies) { company in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.white)
                                            .frame(width: 175, height: 100)
                                            .id(company.id)
                                            .shadow(radius: 3)
                                        Text(company.orginizationName)
                                            .foregroundColor(.black)
                                            .font(.title2)
                                    }
                                }
                            }
                            .scrollTargetLayout()
                        }

                        .contentMargins(.horizontal, 8)
                        .frame(maxHeight: shouldShowListView ? 0 : 175)
                        .opacity(shouldShowListView ? 0: 1)
                        .clipped()
                        .scrollTargetBehavior(.viewAligned)

                        // Bottom stack
                        VStack {
                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVGrid(columns: [GridItem(.flexible())]) {
                                    ForEach(companies) { company in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .frame(height: 150)
                                                .id(company.id)
                                                .shadow(radius: 3)
                                            Text(company.orginizationName)
                                                .foregroundColor(.black)
                                                .font(.title2)
                                        }
                                    }
                                }
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                            }
                            .contentMargins(.horizontal, 8)
                            .frame(maxHeight: shouldShowListView ? .infinity : 0)
                            .opacity(shouldShowListView ? 1: 0)
                        }
                    }
                }
                .frame(maxHeight: shouldShowListView ? .infinity : 200)
                .ignoresSafeArea()
                .background(.regularMaterial)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    NGOMapView()
}

struct CompanyGridScrollView: View {


    let companies: [CompanyObject]


    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(companies) { company in
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .frame(width: 250, height: 150)
                            .id(company.id)
                            .shadow(radius: 3)
                        Text(company.orginizationName)
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                }
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 8)
        .frame(maxHeight: 150)
        .scrollTargetBehavior(.viewAligned)
    }
}


struct CategoryFilterScrollView: View {
    let categories: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(categories, id: \.self) { category in
                    ZStack {
                        Capsule(style: .continuous)
                            .fill(Color.white)
                            .shadow(radius: 3)
                            .frame(height: 30)
                        Text(category)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
            }
        }
        .contentMargins(.horizontal, 8)
        .frame(maxHeight: 50)
        .clipped()
    }
}

struct Category: Hashable {
    let name: String
    let color: Color
}

struct CategoryFilterScrollViewTwo: View {
    let categories: [Category]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(categories, id: \.self) { category in
                    ZStack {
                        RoundButtonView(text: category.name, color: category.color)
                    }
                }
            }
        }
        .contentMargins(.horizontal, 8)
        .frame(maxHeight: 50)
        .clipped()
    }
}



struct RoundButtonView: View {

    let text: String
    let color: Color

    @State var isHighlighted: Bool = false

    var body: some View {
        ZStack {
            isHighlighted ? color : Color.white
            Text(text)
                .fontWeight(.semibold)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .foregroundColor(isHighlighted ? .white : Color.black.opacity(0.7))
        }.onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isHighlighted.toggle()
            }
        }
        .cornerRadius(8)
        .frame(height: 30)
        .clipShape(.capsule)
        .shadow(radius: isHighlighted ? 0 : 3)
    }
}
