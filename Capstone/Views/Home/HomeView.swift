//
//  HomeView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var businessViewModel = BusinessViewModel()
    
    @State var isMapShowing = false
    @Binding var selectedIndex: Int
        
    //MARK: - Body
    
    var body: some View {

        if authViewModel.user?.accountType == "Personal" {
            TabView(selection: $selectedIndex) {
                ProfileView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "person")
                    }.tag(0)
                
                BusinessListView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "list.bullet")
                    }.tag(1)
                
                BusinessMapView()
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "map")
                    }.tag(2)
                
                ConversationsView()
                    .onTapGesture {
                        selectedIndex = 3
                    }
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right")
                    }.tag(3)
            }
        } else {
            TabView(selection: $selectedIndex) {
                InspectBusinessView(businessViewModel: businessViewModel)
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "cart")
                    }
                    .onAppear(perform: {
                        businessViewModel.fetchUserBusiness()
                    })
                    .tag(0)
                
                EditBusinessView(businessViewModel: businessViewModel)
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                    }
                    .onAppear(perform: {
                        businessViewModel.fetchUserBusiness()
                    })
                    .tag(1)
                
                ConversationsView()
                    .onTapGesture {
                        selectedIndex = 2
                    }
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right")
                    }
                    .tag(2)
            }
        }
    }
}

