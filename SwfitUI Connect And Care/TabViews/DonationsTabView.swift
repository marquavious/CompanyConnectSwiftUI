//
//  DonationsTabView.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI

struct DonationsView: View {

    struct Constants {
        static let contentPadding = EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        static let headerTitle = "Scheduled"
        static let navigationTitle = "Donations"
    } 

    private enum Icons: String {
        case rightToolbar = "plus.circle"
    }

    @Environment (\.colorScheme) var colorScheme

    let user: User

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(user.donations) {
                        DonationCellView(donation: $0)
                    }
                }
                Section {
                    ForEach(user.scheduledDonations) {
                        DonationCellView(donation: $0)
                    }
                }
            header: {
                Text(Constants.headerTitle)
                    .font(.title3)
                    .padding([.vertical])
            } footer: {
                // - TODO: Replace Fake Text with Text Generators
                Text(CompanyObject.generateShort())
                    .font(.caption)
                    .padding([.vertical])
                }
            }
            .contentMargins([.top], Constants.contentPadding)
            .navigationTitle(Constants.navigationTitle)
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.hidden)
            .toolbar {
                Button(String(), systemImage: Icons.rightToolbar.rawValue) {
                    // - TODO: Add donation flow
                }
                .tint(colorScheme == .light ? .black:.white)
            }
        }
    }
}

#Preview {
    DonationsView(user: User.createFakeUserData())
}
