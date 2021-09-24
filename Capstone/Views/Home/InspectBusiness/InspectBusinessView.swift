//
//  InspectBusinessView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct InspectBusinessView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var businessViewModel: BusinessViewModel
    
    var body: some View {
        VStack {
            Text(businessViewModel.business?.businessName ?? "No name")
            
            Text(businessViewModel.business?.description ?? "No description")
                .multilineTextAlignment(.center)
        }
    }
}
