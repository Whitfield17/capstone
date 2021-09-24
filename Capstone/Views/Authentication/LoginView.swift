//
//  LoginView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack(alignment: .center, spacing: 20) {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 100)
                            .padding(.top, 88)
                            .padding(.bottom, 32)
                        
                        TextField("Email", text: $email)
                        
                        TextField("Password", text: $password)
                        
                    }
                    .padding(.horizontal, 32)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {  }, label: {
                            Text("Forgot Password?")
                                .font(.footnote)
                                .bold()
                                .padding(.top, 16)
                                .padding(.trailing, 32)
                        })
                    }
                    
                    Button(action: {
                        authViewModel.login(withEmail: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .padding()
                    })
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: RegistrationView().navigationBarBackButtonHidden(true),
                        label: {
                            HStack {
                                Text("Don't have an account?")
                                    .font(.system(size: 14))
                                
                                Text("Sign Up")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(.bottom, 40)
                        })
                }
            }
            .ignoresSafeArea()
        }
    }
}

