//
//  NGOMapView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/29/23.
//

import SwiftUI
import MapKit

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?

    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, image: UIImage?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

// Create the custom view
struct CustomAnnotationView: View {
    var annotation: CustomAnnotation

    var body: some View {
        ZStack {
            Image(uiImage: annotation.image!)
            Text(annotation.title!)
                .font(.headline)
            Text(annotation.subtitle!)
                .font(.subheadline)
        }
    }
}

struct NGOMapView: View {


    @Environment(\.colorScheme) var colorScheme
    @State var shouldShowListView: Bool = false
    @State var shouldLockMap: Bool = false

    @State private var presentedNgos: [CompanyObject] = []

    @StateObject var viewModel = NGOMapViewViewModel()

    var body: some View {
        NavigationStack(path: $presentedNgos) {
//            ZStack {
                MapReader { reader in
                    Map() {
                        ForEach(viewModel.presentedCompanies) { company in
                            Annotation(company.orginizationName, coordinate: company.coordinate) {
                                ZStack {
                                    VStack(spacing: 1) {
                                        Circle()
                                            .fill(Color.white.opacity(0.7))
                                            .frame(width: 40, height: 40)
                                            .overlay {
                                                company.logo
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .clipShape(Circle())
                                                    .padding(8)
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
                }

                VStack(spacing: 0)  {
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
//            }
            .environmentObject(viewModel)
            .navigationDestination(for: CompanyObject.self) { company in
                NGOProfileView(companyObject: company)
                    .navigationBarBackButtonHidden(true)
//                    .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}

struct CategoryFilterScrollView: View {

    @EnvironmentObject var viewModel: NGOMapViewViewModel
    var onTapAction: ((Category) -> Void)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(viewModel.categories, id: \.self) { category in
                    ZStack {
                        RoundButtonView(text: category.name, color: category.color, isHighlighted: viewModel.selctedCategories.contains(category))
                            .onTap { _ in
                                onTapAction(category)
                            }
                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    }
                }
            }
        }
        .contentMargins(.horizontal, 8)
    }
}

struct RoundButtonView: View {
    let text: String
    let color: Color

    @Environment(\.colorScheme) var colorScheme

    var onTapAction: ((Bool) -> Void)?

    var isHighlighted: Bool = true

    var body: some View {
        ZStack {
            colorScheme == .light ? (isHighlighted ? color : Color.white) :
            (isHighlighted ? color : Color.clear)

            Text(text)
                .fontWeight(.medium)
                .padding([.leading, .trailing], 16)
                .foregroundColor(
                    colorScheme == .light ? (isHighlighted ? .white : Color.black.opacity(0.7)) : .white
                )
        }.onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                onTapAction?(isHighlighted)
            }
        }
        .background(colorScheme == .light ? Color.clear : .gray.opacity(0.3))
        .cornerRadius(8)
        .frame(maxHeight: 30)
    }
}

extension RoundButtonView {
    func onTap(_ handler: @escaping (Bool) -> Void) -> RoundButtonView {
        var new = self
        new.onTapAction = handler
        return new
    }
}

struct CompanyHGrid: View {
    @EnvironmentObject var viewModel: NGOMapViewViewModel
    @Environment(\.colorScheme) var colorScheme
    @Binding var shouldShowListView: Bool
    var onTapAction: ((CompanyObject) -> Void)

    let cellSize = CGSize(width: 350, height: 150)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())]) {
                ForEach(viewModel.presentedCompanies) { company in
                    CompanyCardView(onTapAction: onTapAction, cellSize: cellSize)
                        .frame(maxWidth: cellSize.width, maxHeight: cellSize.height)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 8)
        .frame(maxHeight: shouldShowListView ? 0 : 230)
        .opacity(shouldShowListView ? 0 : 1)

    }
}

extension CompanyHGrid {
    func onTap(_ handler: @escaping (CompanyObject) -> Void) -> CompanyHGrid {
        var new = self
        new.onTapAction = handler
        return new
    }
}

struct CompanyVGrid: View {
    @EnvironmentObject var viewModel: NGOMapViewViewModel
    @Binding var shouldShowListView: Bool
    var onTapAction: ((CompanyObject) -> Void)

    let cellSize = CGSize(width: 350, height: 150)

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    CompanyCardView(onTapAction: onTapAction, cellSize: cellSize)
                        .frame(maxHeight: cellSize.height)
                }
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 0, trailing: 8))
            }
            .frame(maxHeight: shouldShowListView ? .infinity : 0)
            .contentMargins([.bottom], 8)
            .opacity(shouldShowListView ? 1 : 0)
        }
    }
}

extension CompanyVGrid {
    func onTap(_ handler: @escaping (CompanyObject) -> Void) -> CompanyVGrid {
        var new = self
        new.onTapAction = handler
        return new
    }
}

struct MapControlPanelView: View {

    @Binding var shouldShowListView: Bool
    @Binding var shouldLockMap: Bool

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
                    withAnimation(.easeInOut(duration: 0.4)) {
                        shouldShowListView.toggle()
                    }
                }

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
                        shouldLockMap = false
                    }
                }
        }
        .padding(8)

    }
}

#Preview {
    NGOMapView()
}

struct CompanyCardView: View {

    var onTapAction: ((CompanyObject) -> Void)
    let cellSize: CGSize
    @EnvironmentObject var viewModel: NGOMapViewViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ForEach(viewModel.presentedCompanies) { company in
            ZStack {

                let backgroundColor = colorScheme == .light ?  Color.white : Color.gray.opacity(0.3)

                backgroundColor
                    .cornerRadius(8)
//                    .shadow(radius: 2)
//                    .overlay {
//                        if colorScheme == .dark {
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.white, style: StrokeStyle(lineWidth: 1))
//                        }
//                    }

                HStack(alignment: .top) {
                    
                    let photoSize = CGSize(width: cellSize.width / 3, height: cellSize.height)

                            company.coverImage
                                .resizable()
                                .frame(width: photoSize.height)
                                .id(company.id)
//                                .shadow(radius: 2)
                                .clipped()
                                .cornerRadius(8)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .frame(width: photoSize.height)
                                        .cornerRadius(8)
                                        .opacity(0.3)
                                        .overlay {
                                            HStack {
                                                VStack {
                                                    Spacer()
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .fill(.regularMaterial)
                                                        .frame(width: 40, height: 40)
                                                        .overlay {
//                                                            RoundedRectangle(cornerRadius: 8)
//                                                                .fill(Color.white)
//                                                                .padding(4)
                                                        }
                                                }
                                                Spacer()
                                            }
                                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 0))
                                        }
                                }
                    VStack(alignment: .leading, spacing: 2) {
                        Text(company.orginizationName)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(
                                colorScheme == .light ? Color.black.opacity(0.7) : .white
                            )
                        Text(company.missionStatement)
                            .font(.caption2)
                            .foregroundColor(
                                colorScheme == .light ? Color.black.opacity(0.7) : .white
                            )
                    }
                }
                .padding(8)
            }
            .onTapGesture { _ in
                onTapAction(company)
            }
        }
    }
}

extension CompanyCardView {
    func onTap(_ handler: @escaping (CompanyObject) -> Void) -> CompanyCardView {
        var new = self
        new.onTapAction = handler
        return new
    }
}
