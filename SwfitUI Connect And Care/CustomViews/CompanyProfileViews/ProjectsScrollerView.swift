//
//  ProjectsScrollerView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct ProjectsScrollerView: View {

    struct Constants {
        static let ContentPadding: CGFloat = 0
        static let MinHeight: CGFloat = 500
        static let MinTabViewHeight: CGFloat = 500
        static let TabViewBottomPadding: CGFloat = 50
    }

    @Environment(\.colorScheme) var colorScheme

    let companyObject: CompanyObject

    var body: some View {
        TabView {
            ForEach(companyObject.projects) { project in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.background)

                    VStack(spacing: .zero) {
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
                                    .background(project.status.statusColor)
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
                    maxWidth: UIScreen.main.bounds.width - (Constants.ContentPadding * 4),
                    minHeight: Constants.MinHeight
                )
                .padding([.bottom], Constants.TabViewBottomPadding)
                .shadow(radius: colorScheme == .light ? 1 : 0)
            }
        }
        .frame(minHeight: Constants.MinTabViewHeight, alignment: .top)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }

}

#Preview {
    ProjectsScrollerView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
