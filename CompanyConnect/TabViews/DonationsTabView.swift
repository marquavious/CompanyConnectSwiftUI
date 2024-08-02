//
//  DonationsTabView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import Charts

struct DonationsView: View {

    struct Constants {
        static let ContentPadding = EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        static let HeaderTitle = "Scheduled"
        static let NavigationTitle = "Donations"
    }

    private enum Icons: String {
        case RightToolbar = "plus.circle"
    }

    @Environment (\.colorScheme) var colorScheme

    let viewModel: DonationsViewViewModelType

    var body: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .loading:
                VStack(spacing: 0) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 50, height: 50)
                    Text("Loading Donations...")
                        .foregroundColor(.gray)
                }
                .navigationTitle(Constants.NavigationTitle)
            case .fetched:
                List {
                    Section {
                        ForEach(viewModel.pastDonations) {
                            DonationCellView(donation: $0)
                        }
                    }
                    Section {
                        ForEach(viewModel.scheduledDonations, id: \.id) {
                            DonationCellView(donation: $0)
                        }
                    }
                header: {
                    Text(Constants.HeaderTitle)
                        .font(.title3)
                        .padding([.vertical])
                } footer: {
                    // - TODO: Replace Fake Text with Text Generators
                    Text(StringGenerator.generateShortString())
                        .font(.caption)
                        .padding([.vertical])
                }
                }
                .contentMargins([.top], Constants.ContentPadding)
                .navigationTitle(Constants.NavigationTitle)
                .navigationBarTitleDisplayMode(.large)
                .scrollIndicators(.hidden)
                .toolbar {
                    Button(
                        String(),
                        systemImage: Icons.RightToolbar.rawValue
                    ) {
                        // - TODO: Add donation flow
                    }
                    .tint(colorScheme == .light ? .black:.white)
                }
            case .error(let error):
                // Handle Error
                Text("OOOPS :)")
                    .navigationTitle(Constants.NavigationTitle)
            }
        }
        .task {
            if viewModel.loadingState != .fetched {
                await viewModel.loadDonationsData()
            }
        }
    }

    private func fetchDonations() async {
        await viewModel.loadDonationsData()
    }
}

#Preview {
    DonationsView(viewModel: DevDonationsViewViewModel(loadingState: .fetched))
}
