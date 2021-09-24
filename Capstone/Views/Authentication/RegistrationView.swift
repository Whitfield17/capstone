//
//  RegistrationView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var email = ""
    @State var password = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var businessName = ""
    @State var accountType = Constants.AccountType.personal
    
//    Environment variable used to dismiss registration view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                    .padding(.top, 88)
                    .padding(.bottom, 32)
                
                VStack(spacing: 20) {
                    Picker(selection: $accountType, label: Text("")) {
                        
                        Text("Personal")
                            .tag(Constants.AccountType.personal)
                        
                        Text("Business")
                            .tag(Constants.AccountType.business)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Email", text: $email)
                    
                    TextField("First Name", text: $firstName)
                    
                    TextField("Last Name", text: $lastName)
                    
                    TextField("Password", text: $password)

                }
                .padding(.horizontal, 32)
                
                Button(action: {
                    if accountType == .personal {
                        authViewModel.registerUser(email: email, password: password, firstName: firstName, lastName: lastName, accountType: "Personal")
                    } else if accountType == .business {
                        authViewModel.registerUser(email: email, password: password, firstName: firstName, lastName: lastName, accountType: "Business")
                    }
                }, label: {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(width: 360, height: 50)
                        .clipShape(Capsule())
                        .padding()
                })
                
                Spacer()
                
                Button(action: { mode.wrappedValue.dismiss() }, label: {
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign In")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .padding(.bottom, 40)
                })

            }
        }
        .ignoresSafeArea()
    }
}
