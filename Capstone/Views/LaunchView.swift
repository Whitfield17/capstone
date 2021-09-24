//
//  LaunchView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct LaunchView: View {
    
    //@EnvironmentObject var viewModel: ContentModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var locationViewModel = LocationViewModel()
    @State private var selectedIndex = 1
    
    var body: some View {
    
        if authViewModel.userSession != nil {
            NavigationView {
                //Detect the authorization status of geolocating the user
                if locationViewModel.authorizationState == .notDetermined {
                    
                    //If undetermined, show onboarding
                    OnboardingView()
                    
                } else if locationViewModel.authorizationState == .authorizedAlways || locationViewModel.authorizationState == .authorizedWhenInUse {
                    
                    HomeView(selectedIndex: $selectedIndex)
                        .navigationBarTitle(authViewModel.user?.accountType == "Personal" ? authViewModel.personalAccountTabs(forIndex: selectedIndex) : authViewModel.businessAccountTabs(forIndex: selectedIndex))
                        .navigationBarTitleDisplayMode(.inline)
                    
                } else {
                    
                    //If denied, show denied view
                    LocationDeniedView()
                }
            }
        } else {
            LoginView()
        }
        
    }
}
