//
//  ProjectsScrollerView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct ProjectsScrollerView: View {

    @Environment(\.colorScheme) var colorScheme

    let padding: CGFloat = 8
    let companyObject: CompanyObject

    var body: some View {
        TabView {
            ForEach(companyObject.projects) { project in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.background)

                    VStack(spacing: 0) {
                        Rectangle()
                            .overlay {
                                project.image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(alignment: .center)
                                    .overlay(alignment: .bottom) {

                                    }
                            }
                            .clipped()

                        Divider()

                        VStack(alignment: .leading) {

                            HStack {
                                Text(project.name)
                                    .font(.title2)
                                    .bold()
                                    .padding([.top], 3)

                                Spacer()

                                Text(project.status.displayName)
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .padding([.vertical], 6)
                                    .padding([.horizontal], 8)
                                    .foregroundColor(.white)
                                    .background(.regularMaterial.opacity(0.1))
                                    .background(project.status.displayColor)
                                    .environment(\.colorScheme, .dark)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )

                            }
                            Text(project.description)
                                .font(.subheadline)
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
                .padding([.bottom], 50)
                .shadow(radius: colorScheme == .light ? 1 : 0)
            }
        }
        .frame(minHeight: 600, alignment: .top)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

#Preview {
    NGOProfileView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
