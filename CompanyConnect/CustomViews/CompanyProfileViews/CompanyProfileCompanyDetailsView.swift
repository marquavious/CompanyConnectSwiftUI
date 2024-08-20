//
//  CompanyProfileCompanyDetailsView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 8/19/24.
//

import Foundation
import SwiftUI

struct CompanyProfileCompanyDetailsView: View {

    struct Constants {
        static let CompanyProfilePictureSize: CGSize = CGSize(width: 75, height: 75)
    }

    @State var company: Company
    @Binding var currentTab: CompanyProfileView.ProfileTabs

    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: company.logoImageUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(
                    width: Constants.CompanyProfilePictureSize.width,
                    height: Constants.CompanyProfilePictureSize.height
                )
                .overlay(Circle().stroke(.background, lineWidth: 3))
                .clipShape(Circle())

                Spacer()

                Text("DONATE")
                    .font(.system(size: 15))
                    .fontWeight(.semibold)
                    .padding([.vertical], 6)
                    .padding([.horizontal], 16)
                    .foregroundColor(.white)
                    .background(.regularMaterial.opacity(0.1))
                    .background(.red)
                    .environment(\.colorScheme, .dark)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                // I don't like the way this offset is hard coded, but I will be fixed
                    .offset(y: 25)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(company.orginizationName)
                    .font(.title2)
                    .bold()
                Text("Current Projects: **\(company.projects.count)**")

                Text(company.bio)
                    .font(.subheadline)
            }
            Picker("", selection: $currentTab) {
                Text(CompanyProfileView.ProfileTabs.about.titleString).tag(CompanyProfileView.ProfileTabs.about)
                Text(CompanyProfileView.ProfileTabs.recentActivity.titleString).tag(CompanyProfileView.ProfileTabs.recentActivity)
            }
            .pickerStyle(.segmented)
            .padding([.vertical], 8)

            Divider()
        }
        .padding([.horizontal, .vertical], 16)
    }
}

#Preview {
    CompanyProfileView(companyObject: Company.createFakeCompanyObject())
}
