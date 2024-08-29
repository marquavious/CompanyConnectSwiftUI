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

    struct Constants {
        static let ContentPadding = EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0)
        static let NavigationTitle = "Donations"
    }

    private enum Icons: String {
        case RightToolbar = "plus.circle"
    }

    @State var loadingState: LoadingState = .loading
    @State var privacyStateEnabled: Bool = true
    @State var showPieChart: Bool = false
    @Environment (\.colorScheme) var colorScheme

    @Injected(\.donationsService) var service

    var body: some View {
        NavigationView {
            Group {
                switch loadingState {
                case .loading:
                    BasicLoadingView(
                        titleString: "Loading Donations...",
                        background: Color.white
                    ).task {
                        await fetchDonations()
                    }
                case .fetched(let pastDonations, let scheduledDonations):
                    DonationsListView(
                        pastDonations: pastDonations,
                        scheduledDonations: scheduledDonations,
                        privacyStateEnabled: $privacyStateEnabled,
                        showPieChart: $showPieChart
                    )
                case .error(let error):
                    BasicErrorView(
                        errorString: error.localizedDescription,
                        background: Color.white,
                        retryAction: { Task { await fetchDonations() } })
                }
            }
            .toolbar {

                Button(
                    String(),
                    systemImage: showPieChart ? "chart.pie.fill" : "chart.pie"
                ) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showPieChart.toggle()
                    }
                }
                .tint(colorScheme == .light ? .black:.white)

                Button(
                    String(),
                    systemImage: privacyStateEnabled ? "eye.slash.circle" :  "eye.circle"
                ) {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        privacyStateEnabled.toggle()
                    }
                }
                .tint(colorScheme == .light ? .black:.white)
            }
            .navigationTitle(Constants.NavigationTitle)
            .navigationBarTitleDisplayMode(.large)
        }
    }

    private func fetchDonations() async {
        loadingState = .loading
        do {
            let donationsData = try await service.getDonationsData(forUserID: "test_user_UUID")
            loadingState = .fetched(past: donationsData.pastDonations, scheduled:  donationsData.scheduledDonations)
        } catch {
            loadingState = .error(error)
        }
    }
}

#Preview {
    DonationsView()
}
