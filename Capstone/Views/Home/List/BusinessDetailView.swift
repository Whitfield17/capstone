//
//  BusinessDetailView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-23.
//

import SwiftUI

struct BusinessDetailView: View {
    @ObservedObject var businessDetailViewModel = BusinessDetailViewModel()

    @State var showChat = false
    let business: Business
    var user: User?
    var ownerUid: String?
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            if let user = businessDetailViewModel.user {
                NavigationLink(destination: ChatView(user: user),
                               isActive: $showChat,
                               label: { })
            }
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack (alignment: .leading, spacing: 4) {
                        Text(business.businessName)
                        
                        Text(business.address)
                                                
                    }
                }
                
                Spacer()
                
            }.padding()
            
            //Making the floating button
            Button(action: {
                businessDetailViewModel.fetchBusinessOwner(withOwnerUid: business.ownerUid);
                self.showChat.toggle()
            }, label: {
                Image(systemName: "message")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
        }
    }
}

