//
//  NGOMapView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/29/23.
//

import SwiftUI
import MapKit

struct MapObject: Identifiable, Hashable {
    let id = UUID()
    let orginizationName: String
    let coordinate: CLLocationCoordinate2D

    public func hash(into hasher: inout Hasher) {
           return hasher.combine(id)
       }

       public static func == (lhs: MapObject, rhs: MapObject) -> Bool {
           return lhs.id == rhs.id
       }
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct NGOMapView: View {

    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3810397737797, longitude: -103.08776997243048), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    let mapObjects = [
        MapObject(
            orginizationName: "Cars for Kids",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.3810397737797, longitude: -103.08776997243048
            )
        ),
        MapObject(
            orginizationName: "Cars for Kids",
            coordinate: CLLocationCoordinate2D(
                latitude: 42.4400292253286, longitude: -101.99633967980964
            )
        ),
        MapObject(
            orginizationName: "Cars for Kids",
            coordinate: CLLocationCoordinate2D(
                latitude: 38.15224613474516, longitude: -105.74631273626163
            )
        ),
        MapObject(
            orginizationName: "Cars for Kids",
            coordinate: CLLocationCoordinate2D(
                latitude: 37.381049537797, longitude: -103.08444997243048
            )
        ),
        MapObject(
            orginizationName: "Cars for Kids",
            coordinate: CLLocationCoordinate2D(
                latitude: 42.44002934553286, longitude: -101.99633967980964
            )
        ),
        MapObject(
            orginizationName: "Cars for Kids",
            coordinate: CLLocationCoordinate2D(
                latitude: 38.15234233474516, longitude: -105.74631273456163
            )
        ),

    ]

    let rows = [
        GridItem(.flexible())
    ]


    @State private var searchBar: String = "Tim"

    var body: some View {
        TabView {
            ZStack {
                Map(coordinateRegion: $region, annotationItems: mapObjects) {
                    MapPin(coordinate: $0.coordinate)
                }.edgesIgnoringSafeArea(.top)
                ScrollViewReader { value in
                    VStack {
                        ZStack {
                            Capsule()
                                .fill(Color.white)
                                .shadow(radius: 3)
//                            TextField("Search Bar", text: $searchBar)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows) {
                                ForEach(mapObjects) { infor in
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white)
                                        .frame(width: 250, height: 150)
                                        .id(infor.id)
                                        .shadow(radius: 3)
//                                        .clipped()
                                        .onTapGesture {
                                            print("COC", infor.id)
                                            withAnimation {
                                                value.scrollTo(infor.id, anchor: .center)
                                                region = MKCoordinateRegion(center: infor.coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
                                            }
                                        }
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)) // Check
                            .scrollTargetLayout()
                        }
                        .frame(maxHeight: 200)
                        .scrollTargetBehavior(.viewAligned)
                    }
                }
            }.tabItem {
                Label("Map", systemImage: "globe.americas")
            }

            TestView()
                .tabItem {
                    Label("Feed", systemImage: "list.bullet.below.rectangle")
                }
        }
    }
}

#Preview {
    NGOMapView()
}

//Map()
