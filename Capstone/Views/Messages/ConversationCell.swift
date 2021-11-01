//
//  ConversationCell.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-11-01.
//

import SwiftUI

struct ConversationCell: View {
    let message: Message
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(message.user.firstName)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(message.text)
                        .font(.system(size: 15))
                        .lineLimit(2)
                }
                //Required for the text to wrap properly
                //.frame(height: 64)
                .foregroundColor(.black)
                .padding(.trailing)
            }
            Divider()
        }
    }
}
