//
//  DonationsTabView.swift
//  CompanyConnect
//
//  Created by Marquavious Draggon on 12/27/23.
//

import SwiftUI
import Charts
import Factory

struct DonationsView: View {

    enum LoadingState: Equatable {

        case loading
        case fetched
        case error(Error)

        static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading), (.fetched, .fetched):
                true
            case let (.error(lhsError), .error(rhsError)):
                lhsError.localizedDescription == rhsError.localizedDescription
            default:
                false
            }
        }
    }

    struct Constants {
        static let ContentPadding = EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        static let HeaderTitle = "Scheduled"
        static let NavigationTitle = "Donations"
    }

    private enum Icons: String {
        case RightToolbar = "plus.circle"
    }

    @Environment (\.colorScheme) var colorScheme
    @State var loadingState: LoadingState = .loading
    @State var pastDonations = [Donation]()
    @State var scheduledDonations = [Donation]()

    @Injected(\.donationsViewService) var service

    var body: some View {
        NavigationView {
            switch loadingState {
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
                        ForEach(pastDonations) {
                            DonationCellView(donation: $0)
                        }
                    }
                    Section {
                        ForEach(scheduledDonations) {
                            DonationCellView(donation: $0)
                        }
                    }
                header: {
                    Text(Constants.HeaderTitle)
                        .font(.title3)
                        .padding([.vertical])
                } footer: {
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
            case .error:
                // Handle Error
                Text("OOOPS :)")
                    .navigationTitle(Constants.NavigationTitle)
            }
        }
        .task {
            if loadingState != .fetched {
                await fetchDonations()
            }
        }
    }

    private func fetchDonations() async {
        loadingState = .loading
        do {
            let donationsData = try await service.getDonationsData(forUserID: "")
            pastDonations = donationsData.pastDonations
            scheduledDonations = donationsData.scheduledDonations
            loadingState = .fetched
        } catch {
            loadingState = .error(error)
        }
    }
}

#Preview {
    DonationsView()
}
