//
//  BusinessDetailView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-23.
//

import SwiftUI

struct BusinessDetailView: View {
    let business: Business
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack (alignment: .leading, spacing: 4) {
                    Text(business.businessName)
                    
                    Text(business.address)

                }
            }
            
            Text (business.description)
                .font(.system(size: 22))
            
            Spacer()
        }.padding()
    }
}

