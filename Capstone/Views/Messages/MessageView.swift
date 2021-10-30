//
//  MessageView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-29.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if(message.isFromCurrentUser) {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.leading, 100)
                    .padding(.trailing, 16)
            } else {
                HStack(alignment: .bottom) {
                    Text(message.text)
                        .padding()
                        .background(Color(.systemGray5))
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .padding(.trailing, 100)
                .padding(.leading, 16)
                Spacer()
            }
        }
    }
}
