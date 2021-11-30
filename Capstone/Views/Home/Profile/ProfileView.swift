//
//  ProfileView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    let user: User
    @ObservedObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init(user: User) {
        self.user = user
        self.profileViewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Text("Logged in as: \(user.firstName)")
                
                Text("Account type: \(user.accountType)")
                
                Button {
                    authViewModel.signOut()
                } label: {
                    Text("Sign out")
                }
            }.padding()

            Divider()
            
            ScrollView {
                ForEach(profileViewModel.businesses()) { business in
                    NavigationLink(
                        destination: LazyView(BusinessDetailView(business: business)),
                        label: { BusinessCell(business: business) }
                    )
                    .foregroundColor(.black)
                    .padding()
                }
            }
        }
        

    }
}
