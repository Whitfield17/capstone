//
//  ConversationsView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct ConversationsView: View {
    
    @ObservedObject var viewModel = ConversationsViewModel()
    @State var user: User?

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.recentMessages) { message in
                    NavigationLink(
                        destination: LazyView(ChatView(user: message.user)),
                        label: {
                            ConversationCell(message: message)
                        })
                }
            }
            .padding()
        }
    }
}
