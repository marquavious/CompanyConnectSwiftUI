////
////  Waste.swift
////  SwfitUI Connect And Care
////
////  Created by Marquavious Draggon on 11/22/23.
////
//
import SwiftUI
//import MapKit

struct TestHeaderView: View {

    @State var offset: CGFloat = 0


    @State var titleOffset: CGFloat = 0

    var headerImage = Image("charleyrivers")

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView(.vertical) {

            VStack(spacing: 15) {
                GeometryReader { proxy -> AnyView in

                    let minY = proxy.frame(in: .global).minY

                    DispatchQueue.main.async {
                        self.offset = minY
                    }

                    return AnyView(
                        ZStack {
                            headerImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                                .cornerRadius(0)

                            BlurView()
                                .opacity(blurViewOpacity())

                        }
                        .clipped()
                        .frame(height: minY > 0 ? 180 + minY : nil)
                        .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)

                    )

                }
                .frame(height: 180)
                .zIndex(1)

                VStack {
                    HStack {
                        headerImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75)
                            .clipShape(Circle())
                            .padding(8)
                            .background(colorScheme == .dark ? .black : .white)
                            .clipShape(Circle())
                            .offset(y: offset < 0 ? getOffset() - 20 : -20)
                            .scaleEffect(getScale())

                        Spacer()

                        Text("Whatever")
                            .padding([.leading, .trailing], 16)
                            .padding([.top, .bottom], 6)
                            .background(Capsule().fill(.purple))
                            .overlay(

                                GeometryReader { proxy -> Color in

                                    let minY = proxy.frame(in: .global).minY
                                    self.titleOffset = minY

                                    return Color.clear

                                }
                                .frame(width: 0, height: 0)


                            , alignment: .top
                        )
                    }
                    .padding([.top], -25)
                    .padding(.bottom, -10)

                }
                .padding(.horizontal)
                .zIndex(-offset > 80 ? 0 : 1)
            }
        }.ignoresSafeArea(.all, edges: .top)

    }

    func getTitleOffset() -> CGFloat {
        let progress = 20 / titleOffset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }

    func getOffset() -> CGFloat {
        let progress = (-offset / 80) * 20

        return progress <= 20 ? progress: 20

    }

    func getScale() -> CGFloat {
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        return scale < 1 ? scale : 1
    }

    func blurViewOpacity() -> Double {
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}


#Preview {
    TestHeaderView()
}


///*
//struct TestView: View {
//    let rows = [
//        GridItem(.flexible())
//    ]
//    @State var selectedItem: Int?
//
//    let info = ["a","b","c","d","e","f"]
//
//    var body: some View {
//        VStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                LazyHGrid(rows: rows) {
//                    ForEach(info, id: \.self) { infor in
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.red)
//                            .frame(width: 150, height: 100)
//                            .onTapGesture {
//                                print(infor)
//                            }
//                    }
//                }.scrollTargetLayout()
//            }
//            .background(Color.blue)
//            .scrollTargetBehavior(.viewAligned)
//        }
//    }
//}
// */
//
///*
//struct TestView: View {
//
//    let rows = [
//        GridItem(.flexible())
//    ]
//
//    @State private var isShowing = false
//    var body: some View {
//        Button("Show Sheet") {
//            isShowing.toggle()
//
//
//        }.sheet(isPresented: $isShowing){
//            sheetView
//                .presentationDetents([.height(200), .large])
//        }
//    }
//
//    var sheetView: some View {
//
//        let mapObjects = [
//            MapObject(
//                orginizationName: "Cars for Kids 1",
//                coordinate: CLLocationCoordinate2D(
//                    latitude: 37.3810397737797, longitude: -103.08776997243048
//                )
//            ),
//            MapObject(
//                orginizationName: "Cars for Kids 2",
//                coordinate: CLLocationCoordinate2D(
//                    latitude: 42.4400292253286, longitude: -101.99633967980964
//                )
//            ),
//            MapObject(
//                orginizationName: "Cars for Kids 3",
//                coordinate: CLLocationCoordinate2D(
//                    latitude: 38.15224613474516, longitude: -105.74631273626163
//                )
//            ),
//            MapObject(
//                orginizationName: "Cars for Kids 4",
//                coordinate: CLLocationCoordinate2D(
//                    latitude: 37.381049537797, longitude: -103.08444997243048
//                )
//            ),
//            MapObject(
//                orginizationName: "Cars for Kids 5",
//                coordinate: CLLocationCoordinate2D(
//                    latitude: 42.44002934553286, longitude: -101.99633967980964
//                )
//            ),
//            MapObject(
//                orginizationName: "Cars for Kids 6",
//                coordinate: CLLocationCoordinate2D(
//                    latitude: 38.15234233474516, longitude: -105.74631273456163
//                )
//            )
//        ]
//
//
//        return ZStack {
//
//            VStack(spacing: 0) {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHGrid(rows: rows) {
//                        ForEach(0..<5) {
//                            Text("\($0) Categorie")
//                                .background(Color.red)
//                                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
//                        }
//                    }
//                }
////                            .background(Color.blue)
//                .frame(maxHeight: 50)
//                ScrollView(.horizontal, showsIndicators: false) {
//                    LazyHGrid(rows: rows) {
//                        ForEach(mapObjects) { infor in
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 8)
//                                    .fill(Color.white)
//                                    .frame(width: 250)
//                                    .id(infor.id)
//                                    .shadow(radius: 3)
//                                    .onTapGesture {
////                                        withAnimation {
////                                            value.scrollTo(infor.id, anchor: .center)
////                                            region = MKCoordinateRegion(center: infor.coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
////                                        }
//                                    }
//
//                                RoundedRectangle(cornerRadius: 8)
//                                    .fill(Color.blue)
//                                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
//                                Text(infor.orginizationName)
//                                    .foregroundColor(.white)
//                            }
//                        }
//                    }
//                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
//                    .scrollTargetLayout()
//                }
//                .frame(maxHeight: 150)
////                            .background(Color.red)
//                .scrollTargetBehavior(.viewAligned)
//                Spacer()
//            }
//        }
//    }
//}
//*/
//
//struct GridPractice: View {
////    @State var shouldShowListView: Bool = false
////    var companies: [CompanyObject] = [
////        CompanyObject(
////            orginizationName: "Cars for Kids 1",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 37.3810397737797, longitude: -103.08776997243048
////            )
////        ),
////        CompanyObject(
////            orginizationName: "Cars for Kids 2",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 42.4400292253286, longitude: -101.99633967980964
////            )
////        ),
////        CompanyObject(
////            orginizationName: "Cars for Kids 3",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 38.15224613474516, longitude: -105.74631273626163
////            )
////        ),
////        CompanyObject(
////            orginizationName: "Cars for Kids 4",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 37.381049537797, longitude: -103.08444997243048
////            )
////        ),
////        CompanyObject(
////            orginizationName: "Cars for Kids 5",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 42.44002934553286, longitude: -101.99633967980964
////            )
////        ),
////        CompanyObject(
////            orginizationName: "Cars for Kids 6",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 38.15234233474516, longitude: -105.74631273456163
////            )
////        )
////    ]
////
////    let categories = [
////        Category(name: "Health Care", color: .red),
////        Category(name: "Women's Advancement", color: .teal),
////        Category(name: "Human Rights", color: .purple),
////        Category(name: "Environmental Issues", color: .mint),
////        Category(name: "Community Building", color: .green),
////        Category(name: "Conflict Relief", color: .pink),
////        Category(name: "Veterans", color: .orange),
////        Category(name: "Education", color: .blue),
////        Category(name: "Indigenous Rights", color: .yellow)
////    ]
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            ZStack {
//                Color.white.ignoresSafeArea()
//                VStack(spacing: 0) {
//                    HStack {
//                        Spacer()
//                        Button("Search") {
//                            withAnimation {
//                                shouldShowListView.toggle()
//                            }
//                        }
//                        .padding()
//                        .buttonStyle(PrimaryButtonStyle())
//                    }
//
////                    CategoryFilterScrollView(categories: categories)
//                   Rectangle()
//                        .fill(Color.gray.opacity(0.3))
//                        .frame(height: 0.7)
//                        .shadow(radius: 1, y: 1)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        LazyHGrid(rows: [GridItem(.flexible())]) {
//                            ForEach(companies) { company in
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color.white)
//                                        .frame(width: 275, height: 150)
//                                        .id(company.id)
//                                        .shadow(radius: 3)
//                                    Text(company.orginizationName)
//                                        .foregroundColor(.black)
//                                        .font(.title2)
//                                }
//                            }
//                        }
//                        .scrollTargetLayout()
//                    }
//
//                    .contentMargins(.horizontal, 8)
//                    .frame(maxHeight: shouldShowListView ? 0 : 175)
//                    .opacity(shouldShowListView ? 0: 1)
//                    .clipped()
//                    .scrollTargetBehavior(.viewAligned)
//
//                    // Bottom stack
//                    VStack {
//                        ScrollView(.vertical, showsIndicators: false) {
//                            LazyVGrid(columns: [GridItem(.flexible())]) {
//                                ForEach(companies) { company in
//                                    ZStack {
//                                        RoundedRectangle(cornerRadius: 8)
//                                            .fill(Color.white)
//                                            .frame(height: 150)
//                                            .id(company.id)
//                                            .shadow(radius: 3)
//                                        Text(company.orginizationName)
//                                            .foregroundColor(.black)
//                                            .font(.title2)
//                                    }
//                                }
//                            }
//                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
//                        }
//                        .contentMargins(.horizontal, 8)
//                        .frame(maxHeight: shouldShowListView ? .infinity : 0)
//                        .opacity(shouldShowListView ? 1: 0)
//                    }
//
//                }
//            }
//        }
//    }
//}
//
//
//#Preview {
//    GridPractice()
//
//}
//
//struct PrimaryButtonStyle: ButtonStyle {
//    let height: CGFloat = 60
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .font(.callout)
//            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
//            .foregroundColor(.black)
//            .background(configuration.isPressed ? Color.red : Color.yellow)
//            .cornerRadius(.infinity)
//    }
//}
//
//
////
////struct UserInputTextView: View {
////
////    var body: some View {
////
////    }
////}
//
////struct UserInputTextView: View {
////    let prompt: String
////    @State var userInput = ""
////
////    var body: some View {
////        ZStack {
////            Rectangle()
////                .fill(Color.white.opacity(0.08))
////                .cornerRadius(3.0)
////            TextField("", text: $userInput, prompt: Text("\(prompt)").foregroundColor(Color.white.opacity(0.25)))
////                .foregroundColor(Color.white)
////                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
////                .keyboardType(.emailAddress)
////                .autocorrectionDisabled()
////                .tint(Color.white)
////        }
////        .frame(height: 47)
////    }
////}
//
//
////Group {
////    Text("Wait,").foregroundColor(Color(red: 170/255, green: 170/255, blue: 170/255)) +
////    Text(" why do we need your email?")
////        .foregroundStyle(Color.white)
////        .bold()
////}.font(Font.caption2)
//
//
////                Rectangle()
////                    .fill(Color.red)
////                    .frame(width: 100, height: 100)
////                Group {
////                    Text(viewModel.title)
////                        .modifier(OnboardingTitleTextViewModifier())
////                    Text(viewModel.subtitle)
////                        .modifier(OnboardingSubTitleTextViewModifier())
////                }
////                .multilineTextAlignment(.center)
//
//
//
////
////struct PullupSearchView: View {
////
////
////}
//
//
////
////  NGOMapView.swift
////  SwfitUI Connect And Care
////
////  Created by Marquavious Draggon on 11/29/23.
////
//
////import SwiftUI
////import MapKit
////
////struct MapObject: Identifiable, Hashable {
////    let id = UUID()
////    let orginizationName: String
////    let coordinate: CLLocationCoordinate2D
////
////    public func hash(into hasher: inout Hasher) {
////        return hasher.combine(id)
////    }
////
////    public static func == (lhs: MapObject, rhs: MapObject) -> Bool {
////        return lhs.id == rhs.id
////    }
////}
////
////extension CLLocationCoordinate2D: Identifiable {
////    public var id: String {
////        "\(latitude)-\(longitude)"
////    }
////}
////
////struct NGOMapView: View {
////
////    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3810397737797, longitude: -103.08776997243048), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
////
////    public var mapObjects: [MapObject] = [
////        MapObject(
////            orginizationName: "Cars for Kids 1",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 37.3810397737797, longitude: -103.08776997243048
////            )
////        ),
////        MapObject(
////            orginizationName: "Cars for Kids 2",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 42.4400292253286, longitude: -101.99633967980964
////            )
////        ),
////        MapObject(
////            orginizationName: "Cars for Kids 3",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 38.15224613474516, longitude: -105.74631273626163
////            )
////        ),
////        MapObject(
////            orginizationName: "Cars for Kids 4",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 37.381049537797, longitude: -103.08444997243048
////            )
////        ),
////        MapObject(
////            orginizationName: "Cars for Kids 5",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 42.44002934553286, longitude: -101.99633967980964
////            )
////        ),
////        MapObject(
////            orginizationName: "Cars for Kids 6",
////            coordinate: CLLocationCoordinate2D(
////                latitude: 38.15234233474516, longitude: -105.74631273456163
////            )
////        )
////    ]
////    let rows = [
////        GridItem(.flexible())
////    ]
////    let categories = [
////        "Health Care",
////        "Women's Advancement",
////        "Human Rights",
////        "Environmental Issues",
////        "Community Building",
////        "Conflict Relief",
////        "Veterans",
////        "Education",
////        "Indigenous Rights"
////    ]
////
////    @State private var searchBar: String = ""
////
////    var body: some View {
////        TabView {
////            ZStack {
////                Map(coordinateRegion: $region, annotationItems: mapObjects) {
////                    MapPin(coordinate: $0.coordinate)
////                }
////                .edgesIgnoringSafeArea(.top)
////
////                ScrollViewReader { value in
////                    Spacer()
////                    HStack {
////                        Spacer()
////                        Circle()
////                            .fill(Color.red)
////                            .frame(width: 45)
////                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8))
////                    }
////                    ZStack {
////                        VStack(spacing: 0) {
////                            ScrollView(.horizontal, showsIndicators: false) {
////                                LazyHGrid(rows: rows) {
////                                    ForEach(categories, id: \.self) { category in
////                                        Text(category)
////                                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
////                                            .background(Color.white,in: Capsule(style: .continuous))
////                                            .shadow(radius: 3)
////                                    }
////                                }
////                            }
////                            .contentMargins(.horizontal, 8)
////                            .frame(maxHeight: 50)
////
////                            ScrollView(.horizontal, showsIndicators: false) {
////                                LazyHGrid(rows: rows) {
////                                    ForEach(mapObjects) { infor in
////                                        ZStack {
////                                            RoundedRectangle(cornerRadius: 8)
////                                                .fill(Color.white)
////                                                .frame(width: 250)
////                                                .id(infor.id)
////                                                .shadow(radius: 3)
////                                                .onTapGesture {
////                                                    withAnimation {
////                                                        value.scrollTo(infor.id, anchor: .center)
////                                                        region = MKCoordinateRegion(center: infor.coordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
////                                                    }
////                                                }
////
////                                            Text(infor.orginizationName)
////                                                .foregroundColor(.black)
////                                                .font(.title2)
////                                        }
////                                    }
////                                }
////                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
////                                .scrollTargetLayout()
////                            }
////                            .contentMargins(.horizontal, 8)
////                            .frame(maxHeight: 150)
////                            .scrollTargetBehavior(.viewAligned)
////                        }
////                        .safeAreaPadding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
////                    }
////                }
////            }
////        }.tabItem {
////            Label("Map", systemImage: "globe.americas")
////        }
////    }
////}
////
////#Preview {
////    NGOMapView()
////}
////
////
//////
//////struct PullupSearchView: View {
//////
//////
//////}
////
//
//
////
////extension CLLocationCoordinate2D: Identifiable {
////    public var id: String {
////        "\(latitude)-\(longitude)"
////    }
////}
//
//
//
////ZStack {
////    Rectangle()
////        .fill(Color.blue)
////        .ignoresSafeArea()
////
////
////    VStack {
////        if shouldShowVerticleScrollingStack {
////            VStack {
////                ScrollView(.horizontal , showsIndicators: false) {
////                    LazyHGrid(rows: gridItems) {
////                        ForEach(0..<10) { _ in
////                            Rectangle()
////                                .fill(Color.green)
////                                .frame(minWidth: 50)
////                        }
////                    }
////                }
////                .contentMargins(.horizontal, 8)
////                .frame(height: shouldShowVerticleScrollingStack ? .infinity : 0)
////            }
////        } else {
////            VStack {
////
////                ScrollView(.vertical, showsIndicators: false) {
////                    LazyVGrid(columns: gridItems) {
////                        ForEach(0..<10) { _ in
////                            Rectangle()
////                                .fill(Color.green)
////                                .frame(minHeight: 50)
////                                .shadow(radius: 3)
////                        }
////                    }
////                }
////                .contentMargins(.horizontal, 8)
////            }.frame(height: .infinity)
////        }
////
////
////        Button("Switch") {
////            withAnimation(.linear(duration: 0.6)) {
////                shouldShowVerticleScrollingStack.toggle()
////            }
////        }
////        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
////        .foregroundColor(.white)
////        .background(.teal, in: Capsule())
////    }
////}
