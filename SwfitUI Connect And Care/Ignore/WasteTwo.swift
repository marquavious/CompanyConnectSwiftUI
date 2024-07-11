//
//  WasteTwo.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 1/15/24.
//

import Foundation
import SwiftUI


struct WasteTwo: View {

    @Namespace var animationNamespace

    @State var selectedCell: String = "0"

    @State var isExpanded: Bool = false

    var body: some View {
        ScrollView {
//            Button("SS") {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }
            ForEach(0..<100) { id in
                LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading) {
                    CellView(nameSpace: animationNamespace, id: String(id), isExpanded: $isExpanded, cellSelected: { id in
                        print(id)
//                        selectedCell = id
                        withAnimation(.easeInOut(duration: 0.4).delay(0.5)) {
                            isExpanded.toggle()
                        }
                    })
//                    Rectangle()
//                        .fill(.red)
//                        .matchedGeometryEffect(
//                            id: isExpanded ? "" : String(id),
//                            in: animationNamespace,
//                            properties: .frame,
//                            anchor: .center,
//                            isSource: false
//                        )
//                        .frame(height: 200)
//                        .overlay {
//                            Text("\(id)")
//                        }
//                        .onTapGesture {
//                            selectedCell = String(id)
//                            withAnimation(.easeInOut(duration: 0.4)) {
//                                isExpanded.toggle()
//                            }
//                        }
                }
            }
        }.overlay(alignment: .center) {
            if isExpanded {
                ZStack {
                    Color.black
                        .opacity(isExpanded ? 1 : 0)

                    }
                }
//                .opacity(isExpanded ? 1 : 0)
        }.overlay {
            if isExpanded {
                VStack {
                    Rectangle().fill(.green.opacity(1))
                        .frame(height: 200)
                        .matchedGeometryEffect(
                            id:  selectedCell ,
                            in: animationNamespace,
                            properties: .frame,
                            anchor: .center,
                            isSource: true)
                        .frame(height: 200)
                    
                    Button("BUTTON \(selectedCell ?? "5")") {
                        withAnimation(.easeInOut(duration: 0.4).delay(0.6)) {
                            isExpanded.toggle()
                            //                                selectedCell = nil
                        }
                    }.background(Color.yellow)
                    
                }
            }
        }
    }
}

#Preview {
    WasteTwo()
}

struct CellView: View {
    var nameSpace: Namespace.ID
    var id: String

    @Binding var isExpanded: Bool

    var cellSelected: ((String) -> Void)
    var body: some View {
        Rectangle()
            .fill(.red)
            .frame(height: 200)
            .overlay {
                Text("\(id)")
            }
            .onTapGesture {
                cellSelected(id)
            }
            .matchedGeometryEffect(
                id: isExpanded ? "" : id,
                in: nameSpace,
                properties: .frame,
                anchor: .center,
                isSource: false
            )

    }
}
