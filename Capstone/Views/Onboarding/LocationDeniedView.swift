//
//  LocationDeniedView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct LocationDeniedView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to access your location to provide you with the best small businesses in your area. You can change your decision at any time in Settings.")
              
            Spacer()
            
            Button {
                
                //Open settings by getting the settings url
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        
                        //If we can open this settings url, then open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            } label: {
                
                ZStack {
                    
                    Text("Go to Settings")
                        .bold()
                        .padding()
                }
            }
            .padding()
            
            Button {
                authViewModel.signOut()
            } label: {
                Text("Sign out")
            }

            Spacer()
            
        }
        .multilineTextAlignment(.center)
        .ignoresSafeArea(.all, edges: .all)
    }
}
