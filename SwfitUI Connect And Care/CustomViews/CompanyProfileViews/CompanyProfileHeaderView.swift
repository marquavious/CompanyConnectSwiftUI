//
//  CompanyProfileHeaderView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 7/15/24.
//

import Foundation
import SwiftUI

struct CompanyProfileHeaderView: View {

    @Binding var currentTab: CompanyProfileView.ProfileTabs

    let companyObject: CompanyObject

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                LogoImageView(
                    logoImageViewData: companyObject.logoImageData,
                    size: CGSize(width: 75, height: 75),
                    overrideLogoWithFontSize: .largeTitle
                )
                .overlay(
                    Circle()
                        .stroke(.background, lineWidth: 3)
                )

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
                    .offset(y: 60)
                    .padding([.trailing], 8)
            }
        }

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

#Preview {
    CompanyProfileView(companyObject: CompanyObject.createFakeComapnyList().first!)
}
