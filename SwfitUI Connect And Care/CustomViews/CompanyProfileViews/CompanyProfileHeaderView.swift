//
//  CompanyProfileHeaderView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct CompanyProfileHeaderView: View {
    var companyObject: CompanyObject
    @Binding var currentTab: CompanyProfileView.ProfileTabs
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Rectangle()
                    .fill(.background)
                    .overlay(alignment: .top) {
                        companyObject.coverImage
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150, alignment: .bottom)
                            .ignoresSafeArea()
                            .overlay(alignment: .leading) {
                                /* Not sure what to do here Im burnt
                                Image(systemName: "arrow.backward")
                                    .frame(width: 20,height: 20)
                                    .foregroundColor(.white)
                                    .environment(\.colorScheme, .dark)
                                    .clipShape(Circle())
                                    .padding([.horizontal], 16)
                                    .offset(y: -30)
                                 */
                            }
                            .overlay(alignment: .bottom) {
                                HStack {
                                    LogoImageView(
                                        logoImageViewData: companyObject.logoImageData,
                                        showIconOnly: false,
                                        size: CGSize(width: 100, height: 100)
                                    )
                                    .overlay(
                                        Circle()
                                            .stroke(.background, lineWidth: 3)
                                    )
                                    .offset(x: 16, y: 50)

                                    Spacer()

                                    Text("DONATE")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .padding([.vertical], 6)
                                        .padding([.horizontal], 8)
                                        .foregroundColor(.white)
                                        .background(.regularMaterial.opacity(0.1))
                                        .background(.red)
                                        .environment(\.colorScheme, .dark)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 8)
                                        )
                                        .offset(y: 80)
                                        .padding([.trailing], 8)
                                }
                            }
                            .ignoresSafeArea(.all, edges: .top)
                        // TODO: - Comback to this
                        // .navigationBarBackButtonHidden(true)
                    }
            }
            .frame(height: 210)

            VStack(alignment: .leading, spacing: 8) {
                Text(companyObject.orginizationName)
                    .font(.title2)
                    .bold()
                Text("Current Projects: **\(companyObject.projects.count)**")

                Text(companyObject.bio)
                    .font(.subheadline)
            }
            .padding([.horizontal])

            Picker("", selection: $currentTab) {
                Text("ABOUT").tag(CompanyProfileView.ProfileTabs.about)
                Text("RECENT ACTIVITY").tag(CompanyProfileView.ProfileTabs.activity)
            }
            .pickerStyle(.segmented)
            .padding([.horizontal], 16)

            Divider()
                .padding([.top], 8)

        }
    }

}

#Preview {
    CompanyProfileView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
