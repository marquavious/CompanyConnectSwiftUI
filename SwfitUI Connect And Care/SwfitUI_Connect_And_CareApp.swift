//
//  SwfitUI_Connect_And_CareApp.swift
//  SwfitUI Connect And Care
//
//  Created by Marquavious Draggon on 11/19/23.
//

import SwiftUI

@main
struct SwfitUI_Connect_And_CareApp: App {

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

/*
class UserInputViewControllerViewModel: ObservableObject {
    @Published var userInputViewObject: UserInputViewObjectViewModel

    init() {
        self.userInputViewObject = UserInputViewObject(
            image: Image("person.badge.key"),
            title: "This is a smaple User Input Title",
            subtitle: "Below, you should see all of your custom Input Fields",
            actionButtonText: "Action Button Text",
            userInputTextFields: UserInputTextField(prompt: "Test Input", type: .generic)
        )
    }
}
 */

struct MainView: View {
    var body: some View {
        TabView {

            ActivityFeedView().tabItem {
                Label("Feed", systemImage: "bubble.circle.fill")
            }


            NGOMapView()
                .tabItem {
                    Label("Map", systemImage: "globe.americas")
                }

            DonationsView()
                .tabItem {
                    Label("Donations", systemImage: "dollarsign.circle")
                }
        }
    }
}

struct UserInputTextField: Hashable {
    let prompt: String
    let type: UserInputTextType
}

enum UserInputTextType {
    case name, email, phoneNumber, generic
}


#Preview {
    MainView()
}
