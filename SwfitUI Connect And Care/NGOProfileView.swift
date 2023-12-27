//
//  NGOProfileView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/30/23.
//

import SwiftUI
import MapKit

struct NavBackButton: View {
    let dismiss: DismissAction

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image("...custom back button here")
        }
    }
}

struct NGOProfileTextView<Content: View>: View {

    enum MediaLocation {
        case top, middle, bottom, none
    }

    let titleText: String
    let text: String?
    let mediaLocation: MediaLocation

    let viewBuilder: () -> Content?

    init(
        titleText: String,
        text: String? = nil,
        mediaLocation: MediaLocation = .none,
        @ViewBuilder viewBuilder: @escaping () -> Content? = { nil }) {

            self.titleText = titleText
            self.text = text
            self.mediaLocation = mediaLocation
            self.viewBuilder = viewBuilder
        }

    var body: some View {

        VStack(alignment: .leading) {

            if mediaLocation == .top { viewBuilder() }

            Text(titleText)
                .font(.title)
                .bold()
                .padding([.top, .bottom], 8)
                .padding([.leading, .trailing])

            if mediaLocation == .middle { viewBuilder() }

            if let text = text {
                Text(text)
                    .padding([.leading, .trailing, .bottom])
            }

            if mediaLocation == .bottom { viewBuilder() }
        }
    }
}

struct NGOProfileView: View {

    init(companyObject: CompanyObject) {
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.2)

        self.companyObject = companyObject
    }

    let companyObject: CompanyObject

    @State var offset: CGFloat = 0

    @Environment(\.dismiss) private var dismiss

    @State var titleOffset: CGFloat = 0

    var headerImage = Image("charleyrivers")

    @Environment(\.colorScheme) var colorScheme



    var body: some View {

        ZStack {

            ScrollView(.vertical, showsIndicators: false) {

                VStack(spacing: 15) {
                    GeometryReader { proxy -> AnyView in

                        let minY = proxy.frame(in: .global).minY

                        DispatchQueue.main.async {
                            self.offset = minY
                        }

                        return AnyView(
                            ZStack {
                                companyObject.coverImage
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

                    VStack(alignment: .leading) {
                        HStack {
                            companyObject.logo
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75)
                                .clipShape(Circle())
                                .padding(8)
                                .background(colorScheme == .dark ? .black : .white)
                                .clipShape(Circle())
                                .offset(y: offset < 0 ? getOffset() - 20 : -20)
                                .scaleEffect(getScale())
                                .padding(.horizontal, 8)

                        }
                        .padding([.top], -30)

                        VStack(alignment: .leading) {
                            Text(companyObject.orginizationName)
                                .font(.title)
                                .bold()

                            Text("Current Projects: **\(companyObject.projects.count)**")

                            Text(CompanyObject.generateShort())
                        }
                        .padding([.horizontal])
                        .offset(y: -20)

                        Divider()

                        NGOProfileTextView(
                            titleText: "Mission Statment",
                            text: companyObject.briefHistoryObject.history,
                            mediaLocation: .bottom
                        ) { }

                        Divider()

                        NGOProfileTextView(
                            titleText: "Our Team",
                            mediaLocation: .bottom
                        ) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: [GridItem()]) {
                                    ForEach(companyObject.team, id: \.id) { member in
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(.background)
                                            VStack {
                                                member.image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .clipShape(Circle())
                                                    .shadow(radius: 2)

                                                VStack(alignment: .center) {
                                                    Text(member.name)
                                                        .font(.title3)
                                                        .bold()
                                                    Text(member.position)
                                                        .font(.callout)
                                                        .italic()
                                                        .foregroundColor(.gray)
                                                }
                                                .padding(8)
                                            }
                                        }
                                        .frame(minWidth: 12, maxHeight: 175)
                                        .padding([.bottom, .trailing, .top], 8)
                                    }
                                }
                            }
                            .contentMargins(.horizontal, 16)
                        }

                        Divider()

                        NGOProfileTextView(
                            titleText: "Brief History",
                            text: companyObject.briefHistoryObject.history,
                            mediaLocation: .bottom
                        ) {
                            VStack(alignment: .center) {
                                TabView {
                                    ForEach(companyObject.briefHistoryObject.imageObjects, id: \.self) { object in
                                        VStack {
                                            Rectangle()
                                                .fill(.background)
                                                .overlay {
                                                    VStack {
                                                        object.image
                                                            .resizable()

                                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                                            .padding([.leading, .trailing])
                                                        Spacer()

                                                        Text(object.caption)
                                                            .font(.callout.italic())
                                                            .padding(8)
                                                    }
                                                }
                                            Spacer(minLength: 40)
                                        }
                                    }
                                }
                                .frame(minHeight: 300, alignment: .top)
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                            }
                        }

                        Divider()

                        NGOProfileTextView(
                            titleText: "Location",
                            text: companyObject.missionStatement,
                            mediaLocation: .middle
                        ) {
                            Map(bounds:
                                    MapCameraBounds(minimumDistance: 4500,
                                                    maximumDistance: 4500),
                                interactionModes: []) {

                                Annotation("", coordinate: companyObject.coordinate) {
                                    VStack(spacing: 1) {
                                        Circle()
                                            .fill(Color.white.opacity(0.7))
                                            .frame(width: 40, height: 40)
                                            .overlay {
                                                Circle()
                                                    .fill(Color.white)
                                                    .padding(6)
                                            }

                                        Triangle()
                                            .fill(Color.white.opacity(0.7))
                                            .frame(width: 15, height: 10)
                                            .rotationEffect(.degrees(180))
                                    }
                                }
                            }
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding([.leading, .trailing, .bottom])
                            .mapStyle(.hybrid)
                        }

                        Divider()

                        NGOProfileTextView(
                            titleText: "Projects",
                            mediaLocation: .middle
                        ) {

                            let padding: CGFloat = 8
                            TabView {
                                ForEach(companyObject.team, id: \.id) { member in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(.background)

                                        VStack(spacing: 0) {
                                            Rectangle()
                                                .overlay {
                                                    member.image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(alignment: .center)
                                                }
                                                .clipped()

                                            Divider()

                                            VStack(alignment: .leading) {
                                                Text(member.name)
                                                    .font(.title2)
                                                    .fontWeight(.semibold)
                                                    .padding([.top], 3)
                                                Text(member.bio)
                                                    .padding([.top], 3)
                                                    .padding([.bottom], 8)
                                            }
                                            .padding(8)
                                            
                                        }

                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .frame(
                                        maxWidth: UIScreen.main.bounds.width - (padding * 4),
                                        minHeight: 500
                                    )
                                    .shadow(radius: 2)
                                    .padding([.bottom], 50)
                                }
                            }
                            .frame(minHeight: 600, alignment: .top)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        }



                    }
                    .zIndex(-offset > 80 ? 0 : 1)
                }
            }

            .ignoresSafeArea(.all, edges: .top)

            VStack {

                HStack {
                    Image(systemName: "chevron.left")
                        .frame(width: 20,height: 20)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.regularMaterial)
                        .environment(\.colorScheme, .dark)
                        .clipShape(Circle())
                        .onTapGesture { dismiss() }

                    Spacer()

                    Text("DONATE")
                        .font(.system(size: 15))
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .padding([.vertical], 6)
                        .padding([.horizontal], 8)
                        .foregroundColor(.white)
                        .background(.regularMaterial.opacity(0.1))
                        .background(Color(red: 255/255, green: 75/255, blue: 96/255))
//                        .backgroundColor(.red)
                        .environment(\.colorScheme, .dark)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 8)
//                                .fill(.red)
                        )
                        .onTapGesture {
                            dismiss()
                        }
                }
                .offset(y: -10)
                .padding(.horizontal)

                /*
                HStack {
                    Image(systemName: "chevron.left")
                        .frame(width: 20,height: 20)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.regularMaterial)
                        .environment(\.colorScheme, .dark)
                        .clipShape(Circle())
                        .transition(.scale)
                        .padding(.horizontal)
//                        .padding(.bottom, 20)

//                    Button(Image("chevron.left")) {
//
//                    }
//                    Image("chevron.left")
//                        .
//                    .padding(.horizontal)
                    Spacer()
                }
                 */

                Spacer()
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(.background)
//                    .shadow(radius: 2)
//                    .frame(maxHeight: 80)
//                    .overlay {
//                        HStack {
//                            Button("DONATE") {
////                                dismiss()
//                            }
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .background(
//                                RoundedRectangle(cornerRadius: 8).fill(Color(red: 255/255, green: 96/255, blue: 96/255))
//                            )
//                            .foregroundColor(.white)
//                            .padding()
//                        }
//                    }
            }
//            .ignoresSafeArea(edges: .bottom)


        }
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

#Preview {
    NGOProfileView(companyObject: CompanyObject.ceateFakeComapnyList().first!)
}

/*
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
*/


/*

 ScrollView(showsIndicators: false) {
     VStack(alignment: .leading) {


             companyObject.coverImage
                 .resizable()
                 .scaledToFill()
                 .frame(height: 300, alignment: .bottom)
                 .clipped()



         VStack(alignment: .leading) {
//                        Circle()
//                            .fill(Color.white)
//                            .frame(width: 100)

             HStack(alignment: .center) {
             CompanyObject.generateRadomImage()
                 .resizable()
                 .scaledToFill()
                 .clipShape(Circle())
                 .frame(width: 100)
                 .shadow(radius: 2)

                 Spacer()

                 Text(companyObject.category.name)
                     .padding([.leading, .trailing], 16)
                     .padding([.top, .bottom], 6)
//                            .foregroundColor(.blue)
                     .background(Capsule().fill(companyObject.category.color))
             }

             Text(companyObject.orginizationName)
                 .font(.title)
                 .bold()
             Text("Current Projects: **\(companyObject.projects.count)**")

//                        Text(companyObject.category.name)
//                            .padding([.leading, .trailing], 16)
//                            .padding([.top, .bottom], 6)
////                            .foregroundColor(.blue)
//                            .background(Capsule().fill(companyObject.category.color))
//                        HStack {
//                            RoundButtonView(text: companyObject.category.name, color: companyObject.category.color)
//                            Spacer()
//
//                        }
             Text(CompanyObject.generateShort())

         }

         Divider()

         NGOProfileTextView(
             titleText: "Mission Statment",
             text: companyObject.briefHistoryObject.history,
             mediaLocation: .bottom
         ) { }

         Divider()

         NGOProfileTextView(
             titleText: "Our Team",
             mediaLocation: .bottom
         ) {

             ScrollView(.horizontal, showsIndicators: false) {
                 LazyHGrid(rows: [GridItem()]) {
                     ForEach(companyObject.team, id: \.id) { member in
                         ZStack {
                             RoundedRectangle(cornerRadius: 8)
                                 .fill(.background)
                             VStack {
                                 member.image
                                     .resizable()
                                     .scaledToFill()
                                     .clipShape(Circle())
                                     .shadow(radius: 2)

                                 VStack(alignment: .center) {
                                     Text(member.name)
                                         .font(.title3)
                                         .bold()
                                     Text(member.position)
                                         .font(.callout)
                                         .italic()
                                         .foregroundColor(.gray)
                                 }
                                 .padding(8)
                             }
                         }
                         .frame(minWidth: 12, maxHeight: 175)
                         .padding([.bottom, .trailing, .top], 8)
                     }
                 }
             }
             .contentMargins(.horizontal, 16)
         }

         Divider()

         NGOProfileTextView(
             titleText: "Brief History",
             text: companyObject.briefHistoryObject.history,
             mediaLocation: .bottom
         ) {
             VStack(alignment: .center) {
                 TabView {
                     ForEach(companyObject.briefHistoryObject.imageObjects, id: \.self) { object in
                         VStack {
                             Rectangle()
                                 .fill(.background)
                                 .overlay {
                                     VStack {
                                         object.image
                                             .resizable()

                                             .clipShape(RoundedRectangle(cornerRadius: 8))
                                             .padding([.leading, .trailing])
                                         Spacer()

                                         Text(object.caption)
                                             .font(.callout.italic())
                                             .padding(8)
                                     }
                                 }
                             Spacer(minLength: 40)
                         }
                     }
                 }
                 .frame(minHeight: 300, alignment: .top)
                 .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
             }
         }

         Divider()

         NGOProfileTextView(
             titleText: "Location",
             text: companyObject.missionStatement,
             mediaLocation: .middle
         ) {
             Map(bounds:
                   MapCameraBounds(minimumDistance: 4500,
                                   maximumDistance: 4500),
                 interactionModes: []) {

                 Annotation("", coordinate: companyObject.coordinate) {
                     VStack(spacing: 1) {
//
//                                    RoundedRectangle(cornerRadius: 8)
                         Circle()
//                                        .fill(companyObject.category.color)
                             .fill(Color.white.opacity(0.7))
                             .frame(width: 40, height: 40)
                             .overlay {
//                                            RoundedRectangle(cornerRadius: 8)
                                 Circle()
                                     .fill(Color.white)
                                     .padding(6)
                             }
//                                }
//                                .border(.red)

//                                Rectangle()
//                                    .fill(Color.red)
//
//                                Rectangle()
//                                    .fill(Color.red)

                     Triangle()
//                                        .fill(companyObject.category.color)
                         .fill(Color.white.opacity(0.7))
                         .frame(width: 15, height: 10)
//                                    .border(.red)
                         .rotationEffect(.degrees(180))
//                                        .offset(y: 20)
                 }
                 }
             }
             .frame(height: 200)
             .clipShape(RoundedRectangle(cornerRadius: 8))
             .padding([.leading, .trailing, .bottom])
             .mapStyle(.hybrid)
         }

         Divider()

         NGOProfileTextView(
             titleText: "Projects",
             mediaLocation: .middle
         ) {

             let padding: CGFloat = 8
             TabView {
                 ForEach(companyObject.team, id: \.id) { member in
                     ZStack {
                         RoundedRectangle(cornerRadius: 8)
                             .fill(.background)

                         VStack(spacing: 0) {
                             Rectangle()
                                 .overlay {
                                     member.image
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(alignment: .center)
                                 }
                                 .clipped()

                             Divider()

                             VStack(alignment: .leading) {
                                 Text(member.name)
                                     .font(.title2)
                                     .padding([.top], 3)
                                 Text(member.bio)
                                     .padding([.top], 3)
                                     .padding([.bottom], 8)
                             }
                             .padding(8)
                         }
                     }
                     .clipShape(RoundedRectangle(cornerRadius: 8))
                     .frame(
                         maxWidth: UIScreen.main.bounds.width - (padding * 4),
                         minHeight: 500
                     )
                     .shadow(radius: 2)
                     .padding([.bottom], 50)
                 }
             }
             .frame(minHeight: 600, alignment: .top)
             .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
         }

         Divider()

         Spacer()
     }
 }
}
 */
