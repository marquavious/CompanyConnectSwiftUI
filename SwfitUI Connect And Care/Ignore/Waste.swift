//
//  Waste.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/22/23.
//

import SwiftUI
import MapKit

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

//extension View {
//    func getRect() -> CGRect {
//        return UIScreen.main.bounds
//    }
//}

//#Preview {
//    TestHeaderView()
//}

//struct /*TestPage*/: View {

struct TESTVIEWONE: View {
    let AniSN: Namespace.ID

    var body: some View {
        ZStack {
            Rectangle().fill(.blue)
                .matchedGeometryEffect(
                    id: "basic",
                    in: AniSN,
                    properties: .frame,
                    anchor: .center,
                    isSource: true
                )
//                .frame(width: 150, height: 100)
        }
    }
}

struct TESTVIEWTWO: View {
    let AniSN: Namespace.ID
    @Binding var move: Bool

    var body: some View {
        ZStack {
            Rectangle().fill(.green.opacity(0.6))
                .matchedGeometryEffect(
                    id: move ? "" : "basic",
                    in: AniSN,
                    properties: .frame,
                    anchor: .center,
                    isSource: false)
//                .frame(width: 100, height: 50)
        }
    }
}

struct TESTVIEWTHREE: View {
    @Namespace var animation
    @State var isExpanded: Bool = false
    @State var color = Color.red

    var body: some View {
        ZStack {
            color
            TESTVIEWONE(AniSN: animation)
                .frame(width: 200, height: 200)

            //            TESTVIEWTWO(AniSN: animation, move: $isExpanded)

            VStack {
                Button("Change") {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }.foregroundColor(.white)

                Button("Change 2") {
                    withAnimation {
                        color = .white
                    }
                }.foregroundColor(.white)
            }
        }
        .frame(width: .infinity, height: .infinity)
        .overlay {
//            if isExpanded {
                Group {
                    Rectangle().fill(.green.opacity(0.6))
                        .matchedGeometryEffect(
                            id: isExpanded ? "basic" : "",
                            in: animation,
                            properties: .frame,
                            anchor: .center,
                            isSource: false)
//                        .frame(width: 0, height: 0)

                    Button("PRESS") {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
                }
                .opacity(isExpanded ? 1 : 0)
            }
//        }
    }
}

#Preview {
//    TESTVIEWTHREE()
//    ImageObjectView()
    TestPagex()
}

/// CMD SHFT OPTION LEFT!

struct ImageObjectView: View {

    @Namespace var animation
    @State var isExpanded: Bool = false
    @State var expandedProfile: Rectangle?
    @State var loadExpandedContent: Bool = false
    @State var offset: CGSize = .zero

    var activityCaption: String?
//    var image: IdentifiableImage
//    var photoSize: CGSize

    var body: some View {
        ZStack {
            Color.white
            Image(.charleyrivers)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .opacity(isExpanded ? 0 : 1)
                .matchedGeometryEffect(id: "ID", in: animation)
                .cornerRadius(8)
                .onTapGesture {
                    withAnimation(.easeInOut(duration:  0.4)) {
                        isExpanded = true
                    }
                }
        }

        .overlay {
            if isExpanded {
                ExpandedView()
            }
        }
    }

    func offsetProgress() -> CGFloat {
        let progress = offset.height / 200
        if offset.height < 0 {
            return 1
        } else {
            return 1 - (progress < 1 ? progress : 1)
        }
    }

    @ViewBuilder func ExpandedView() -> some View {
        VStack {
            GeometryReader { proxy in
                let size = proxy.size
                Image(.charleyrivers)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height:  size.height)
                    .cornerRadius(loadExpandedContent ? 0 : 8)
                    .offset(y: loadExpandedContent ? offset.height : .zero)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = value.translation
                            }.onEnded { value in
                                let height = value.translation.height

                                if height > 0 && height > 100 {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        loadExpandedContent = false
                                    }
                                    withAnimation(.easeInOut(duration:  0.4).delay(0.05)) {
                                        isExpanded = false
                                    }
                                    // Reset
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        offset = .zero
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        offset = .zero
                                    }
                                }
                            }
                    )
            }
            .matchedGeometryEffect(id: "ID", in: animation)
            .frame(height: 300)
        }
        .frame(width: .infinity, height: .infinity)
        .overlay(alignment: .top) {
            VStack {
                HStack(spacing: 10) {
                    Button {
                        withAnimation(.easeInOut(duration:  0.4)) {
                            loadExpandedContent = false
                        }
                        withAnimation(.easeInOut(duration:  0.4).delay(0.05)) {
                            isExpanded = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .opacity(loadExpandedContent ? 1: 0)
                    .opacity(offsetProgress())
                    Spacer()
                }

                Spacer()

                Divider()
                    .padding([.bottom], 16)
                Text(activityCaption ?? "")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .opacity(loadExpandedContent ? 1: 0)
                    .opacity(offsetProgress())
            }
            .padding()
            .opacity(loadExpandedContent ? 1 : 0)
            .opacity(offsetProgress())
        }
        .background {
            Rectangle()
                .fill(.black)
                .opacity(loadExpandedContent ? 1: 0)
                .opacity(offsetProgress())
                .ignoresSafeArea()
        }
        .transition(.offset(x:0, y: 1))
        .onAppear {
            withAnimation(.easeInOut(duration:  0.4)) {
                loadExpandedContent = true
            }
        }
    }
}

//#Preview {
//    ImageObjectView(image: IdentifiableImage(image: Image(.charleyrivers)), photoSize: CGSize(width: 200, height: 200))
//}

struct CurvedRect: Shape {
    let cornerRadius: CGFloat
    let photoSize: CGSize
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.height - photoSize.height))
            path.addArc(
                tangent1End: CGPoint(x: rect.minX + photoSize.width, y: rect.height -  photoSize.height),
                tangent2End: CGPoint(x: rect.minX + photoSize.width, y: rect.maxY),
                radius: cornerRadius)

            path.addLine(to: CGPoint(x: rect.minX + photoSize.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct LabelShape: Shape {
    let cornerRadius: CGFloat
    let tabWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: cornerRadius, y: rect.height))
        path.addArc(
            tangent1End: CGPoint(x: rect.width, y: rect.height),
            tangent2End: CGPoint(x: rect.width, y: 0),
            radius: cornerRadius)
//        path.addArc(tangent1End: CGPoint(x: rect.width, y: 0), tangent2End: CGPoint(x: 0, y: 0), radius: cornerRadius)
//        path.addArc(tangent1End: CGPoint(x: rect.width - tabWidth, y: 0), tangent2End: CGPoint(x: rect.width - tabWidth, y: rect.height), radius: cornerRadius)
//        path.addArc(tangent1End: CGPoint(x: rect.width - tabWidth, y: cornerRadius * 2), tangent2End: CGPoint(x: 0, y: cornerRadius * 2), radius: cornerRadius)
//        path.addArc(tangent1End: CGPoint(x: 0, y: cornerRadius * 2), tangent2End: CGPoint(x: 0, y: rect.height), radius: cornerRadius)
//        path.addArc(tangent1End: CGPoint(x: 0, y: rect.height), tangent2End: CGPoint(x: rect.width, y: rect.height), radius: cornerRadius)
        return path
    }
}

struct CrazyView: View {

    var body: some View {


//        CurvedRect(cornerRadius: 8, photoSize: CGSize(width: 60, height: 60))
//            .fill(.red)
//            .frame(width: 350,height: 150)
////            .border(Color.blue)
//            .clipShape(RoundedRectangle(cornerRadius: 8))
//
//        LabelShape(cornerRadius: 8, tabWidth: 25)
//            .stroke(.red)
//            .frame(width: 350, height: 100)


        ZStack {
            Color.blue

            HStack {
                Image("face-2")
                    .resizable()
                    .frame(width: 150, height: 150)
                VStack(alignment: .leading, spacing: 2) {
                    Text("company.orginizationName")
                        .font(.headline)
                        .foregroundColor(
                            .black
                        )
                    Text("company.missionStatementcompany.missionStatementcompany.missionStatementcompany.missionStatementcompany.missionStatementcompany.missionStatementcompany.missionStatementcompany.missionStatementcompany.missionStatement")
                        .font(.caption)
                        .foregroundColor(
                            .black
                        )
                }
            }.frame(width: 350,height: 150)
            .mask {
                //                    CurvedRect(cornerRadius: <#CGFloat#>, photoSize: <#CGSize#>)
                //                        .fill(.red)
                //                        .frame(width: 300,height: 100)
                //                }
                CurvedRect(cornerRadius: 8, photoSize: CGSize(width: 40, height: 40))
                    .fill(.red)
//                    .frame(width: 300,height: 100)
//                    .mask {
//                        Image("face-2")
//                    }
            }
        }
    }

}

//#Preview {
//    CrazyView()
//}

//ScrollView(.horizontal) {
//
//    HStack(spacing: 0) {
//        ScrollView {
//
//            ForEach(0..<100) {
//                Text("\($0)")
//                    .frame(width: .infinity)
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        .background(Color.red)
//        .scrollTargetLayout()
//
//        ScrollView {
//            ForEach(0..<100) {
//                Text("-----------------------\($0)-----------------------")
//                    .frame(width: .infinity)
//            }
//        }
//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        .background(Color.blue)
//        .scrollTargetLayout()
//    }
//
//}
//.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//.background( Color.green)
//.scrollTargetBehavior(.paging)
//

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
//#Preview {
//    NGOMapView()
//}
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

/*
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

 */



struct TestPagex: View {

    @Namespace var animation
    @State var isExpanded: Bool =  false
    @State var expandedProfile: Rectangle?
    @State var loadExpandedContent: Bool = false

    @State var offset: CGSize = .zero

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .overlay(alignment: .topLeading) {
                    VStack {
                        Image(.charleyrivers)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .opacity(isExpanded ? 0 : 1)
                            .matchedGeometryEffect(id: "ID", in: animation)
                            .cornerRadius(8)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration:  0.4)) {
                            isExpanded = true
                        }
                    }
                }
            }
            .navigationTitle("WEOO")
        }
        .overlay {
            if isExpanded {
                ExpandedView()
            }
        }
    }

    func offsetProgress() -> CGFloat {
        let progress = offset.height / 100
        if offset.height < 0 {
            return 1
        } else {
            return 1 - (progress < 1 ? progress : 1)
        }
    }

    @ViewBuilder func ExpandedView() -> some View {
        VStack {
            GeometryReader { proxy in
                let size = proxy.size

                Image(.charleyrivers)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height:  size.height)
                    .cornerRadius(loadExpandedContent ? 0 : 8)
                    .offset(y: loadExpandedContent ? offset.height : .zero)
                    .gesture(
                        DragGesture()
                            .onChanged { value in

                                offset = value.translation

                            }.onEnded { value in
                                let height = value.translation.height

                                if height > 0 && height > 100 {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        loadExpandedContent = false
                                    }
                                    withAnimation(.easeInOut(duration:  0.4).delay(0.05)) {
                                        isExpanded = false
                                    }
                                    // Reset
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                        offset = .zero
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        offset = .zero
                                    }
                                }
                            }
                    )

            }
            .matchedGeometryEffect(id: "ID", in: animation)
            .frame(height: 300)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            HStack(spacing: 10) {
                Button {
                    withAnimation(.easeInOut(duration:  0.4)) {
                        loadExpandedContent = false
                    }
                    withAnimation(.easeInOut(duration:  0.4).delay(0.05)) {
                        isExpanded = false
                    }
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Text("PRESS")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            .padding()
            .opacity(loadExpandedContent ? 1 : 0)
            .opacity(offsetProgress())
        }
        .background {
            Rectangle()
                .fill(.black)
                .opacity(loadExpandedContent ? 1: 0)
                .opacity(offsetProgress())
                .ignoresSafeArea()
        }
        .transition(.offset(x:0, y: 1))
        .onAppear {
            withAnimation(.easeInOut(duration:  0.4)) {
                loadExpandedContent = true
            }
        }
    }
}

//
//if isExpanded {
////                ExpandedView(image: IdentifiableImage(image: Image(.charleyrivers)))
////                    .frame(height: .infinity)
//////                    .ignoresSafeArea()
////            }
////            if let currentlySelectedActivityPost = currentlySelectedActivityPost, isExpanded {
////                if case let .photo(photo) = currentlySelectedActivityPost.media {
////                    //                    ExpandedView(image: photo)
////                    ExpandedView(image: IdentifiableImage(image: Image(.charleyrivers)))
////                        .frame(height: .infinity)
////                    //                    print("Selected")
////                }
////            }
////            } else {
//////                print("dd")
////
////                Rectangle()
////                    .fill(.white)
////                    .frame(width: 100, height: 100)
////            }
//
////            if  isExpanded {
////
////                ExpandedView(image: IdentifiableImage(image: Image(.charleyrivers)))
//////                    .matchedGeometryEffect(
//////                        id: isExpanded ? "" : "basic",
//////                        in: MediaFocusedAnimation,
//////                        properties: .frame,
//////                        anchor: .center,
//////                        isSource: true
//////                    )
//////                    print("Selected")
////
////            }
//
//            /*
//
//            else {
////                print("dd")
//
//                Rectangle()
//                    .fill(.white)
//                    .frame(width: 100, height: 100)
//            }
//             */
//
////            if isExpanded {
////                ExpandedView()
////            }


/*
 @ViewBuilder func ExpandedView(image: IdentifiableImage) -> some View {
     VStack {
         GeometryReader { proxy in
             let size = proxy.size
//                Image(.charleyrivers)
             image.image
//                Rectangle()
//                    .fill(Color.red)
//                    .fill(Color.clear)
                 .resizable()
                 .aspectRatio(contentMode: .fill)
                 .frame(height: 300)
                 .opacity(1)
                 .cornerRadius(loadExpandedContent ? 0 : 8)
                 .offset(y: loadExpandedContent ? offset.height : .zero)
                 .gesture(
                     DragGesture()
                         .onChanged { value in
                             offset = value.translation
                         }.onEnded { value in
                             let height = value.translation.height

                             if height > 0 && height > 100 {
                                 withAnimation(.easeInOut(duration: 0.4)) {
                                     loadExpandedContent = false
                                 }
                                 withAnimation(.easeInOut(duration:  0.4).delay(0.05)) {
                                     isExpanded = false
//                                        = false
//                                        currentlySelectedActivityPost = nil
                                 }
                                 // Reset
                                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                     offset = .zero
                                 }
                             } else {
                                 withAnimation(.easeInOut(duration: 0.4)) {
                                     offset = .zero
                                 }
                             }
                         }
                 )
         }
         .matchedGeometryEffect(
             id: "basic",
             in: MediaFocusedAnimation,
             properties: .frame,
             anchor: .center,
             isSource: true
         )
         .frame(height: 300)
     }
     .frame(maxWidth: .infinity, maxHeight: .infinity)
     .overlay(alignment: .top) {
         VStack {
             HStack(spacing: 10) {
                 Button {
                     withAnimation(.easeInOut(duration:  0.4)) {
                         loadExpandedContent = false
                     }
                     withAnimation(.easeInOut(duration:  0.4).delay(0.05)) {
                         isExpanded = false
                     }
                 } label: {
                     Image(systemName: "xmark")
                         .font(.title3)
                         .foregroundColor(.white)
                 }
                 .opacity(loadExpandedContent ? 1: 0)
                 .opacity(offsetProgress())
                 Spacer()
             }

             Spacer()

             Divider()
                 .padding([.bottom], 16)
             Text("currentlySelectedActivityPost?.caption ?? ")
                 .multilineTextAlignment(.leading)
                 .foregroundColor(.white)
                 .opacity(loadExpandedContent ? 1: 0)
                 .opacity(offsetProgress())
         }
         .padding()
         .opacity(loadExpandedContent ? 1 : 0)
         .opacity(offsetProgress())
     }
     .background {
         Rectangle()
             .fill(.black)
             .opacity(loadExpandedContent ? 1: 0)
             .opacity(offsetProgress())
             .ignoresSafeArea()
     }
     .transition(.offset(x:0, y: 1))
     .onAppear {
         withAnimation(.easeInOut(duration:  0.4)) {
             loadExpandedContent = true
         }
     }
 }


 */


/*
func offsetProgress() -> CGFloat {
    let progress = offset.height / 200
    if offset.height < 0 {
        return 1
    } else {
        return 1 - (progress < 1 ? progress : 1)
    }
}

@ViewBuilder func ExpandedView() -> some View {
    VStack {
        GeometryReader { proxy in
            let size = proxy.size
            Image(.charleyrivers)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height:  size.height)
                .cornerRadius(loadExpandedContent ? 0 : 8)
                .offset(y: loadExpandedContent ? offset.height : .zero)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            offset = value.translation
                        }.onEnded { value in
                            let height = value.translation.height

                            if height > 0 && height > 100 {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    loadExpandedContent = false
                                }
                                withAnimation(.easeInOut(duration:  0.4).delay(0.05)) {
                                    isExpanded = false
                                }
                                // Reset
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    offset = .zero
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    offset = .zero
                                }
                            }
                        }
                )
        }
        .matchedGeometryEffect(id: "ID" , in: animation)
        .frame(height: 300)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .overlay(alignment: .top) {
        VStack {
            HStack(spacing: 10) {
                Button {
                    withAnimation(.easeInOut(duration:  0.4)) {
                        loadExpandedContent = false
                    }
                    withAnimation(.easeInOut(duration:  0.4).delay(0.05)) {
                        isExpanded = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .opacity(loadExpandedContent ? 1: 0)
                .opacity(offsetProgress())
                Spacer()
            }

            Spacer()

            Divider()
                .padding([.bottom], 16)
            Text(currentlySelectedActivityPost?.caption ?? "")
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .opacity(loadExpandedContent ? 1: 0)
                .opacity(offsetProgress())
        }
        .padding()
        .opacity(loadExpandedContent ? 1 : 0)
        .opacity(offsetProgress())
    }
    .background {
        Rectangle()
            .fill(.black)
            .opacity(loadExpandedContent ? 1: 0)
            .opacity(offsetProgress())
            .ignoresSafeArea()
    }
    .transition(.offset(x:0, y: 1))
    .onAppear {
        withAnimation(.easeInOut(duration:  0.4)) {
            loadExpandedContent = true
        }
    }
}
 */
