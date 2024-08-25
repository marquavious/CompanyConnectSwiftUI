//
//  ProjectsScrollerView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct ProjectsScrollerView: View {

    struct Constants {
        static let ContentPadding: CGFloat = 8
        static let MinHeight: CGFloat = 500
        static let MinTabViewHeight: CGFloat = 600
        static let TabViewBottomPadding: CGFloat = 50
    }

    @Environment(\.colorScheme) var colorScheme

    let projects: [Project]

    var body: some View {
        TabView {
            ForEach(projects) { project in
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.background)

                    VStack(spacing: .zero) {
                        Rectangle()
                            .overlay {
                                AsyncImage(url: URL(string: project.imageUrl)) { image in
                                    image
                                        .resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(alignment: .center)
                            }
                            .clipped()

                        Divider()

                        VStack(alignment: .leading) {
                            HStack {
                                Text(project.name)
                                    .font(.title2)
                                    .bold()
                                    .padding(EdgeInsets(top: 3, leading: 8, bottom: 0, trailing: 8))

                                Spacer()

                                Text(project.status.displayName)
                                    .font(.system(size: 15))
                                    .fontWeight(.semibold)
                                    .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
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
                                .padding(EdgeInsets(top: 3, leading: 8, bottom: 8, trailing: 8))
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
    ProjectsScrollerView(projects: Project.generateFakeProjectList())
}
