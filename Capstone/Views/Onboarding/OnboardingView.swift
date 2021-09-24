//
//  OnboardingView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct OnboardingView: View {
    
    //@EnvironmentObject var model: ContentModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var locationViewModel = LocationViewModel()
    @State private var tabSelection = 0
    
    var body: some View {

        VStack {
            
            //Tab view
            TabView(selection: $tabSelection) {
                
                //First tab
                VStack(spacing: 20) {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Welcome to Essell!")
                        .bold()
                        .font(.title)
                    
                    Text("Essell helps you find the best small businesses!")
                }
                .multilineTextAlignment(.center)
                .padding()
                .tag(0)
                
                //Second tab
                VStack(spacing: 20) {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Ready to support your community?")
                        .bold()
                        .font(.title)
                    
                    Text("We'll show you the best restaurants, shops, and more, based on your location!")

                }
                .multilineTextAlignment(.center)
                .padding()
                .tag(1)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            //Button
            Button {
                
                //Detect which tab it is
                if tabSelection == 0 {
                    tabSelection = 1
                } else {
                    
                    //Request for geolocation permission
                    locationViewModel.requestGeolocationPermission()
                }
            } label: {
                
                ZStack {
                    
                    Text(tabSelection == 0 ? "Next" : "Get My Location")
                        .bold()
                        .padding()
                }
            }
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .all)

    }
}
