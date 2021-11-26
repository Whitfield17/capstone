//
//  BusinessCell.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-23.
//

import SwiftUI

struct BusinessCell: View {
    let business: Business
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 12) {
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(business.businessName)
                        
                        Text(business.address)
                        
                        Text(business.city)
                    }
                    
                    Text(business.description)
                    
                        
                }
            }
            
            Divider()
        }
    }
}
