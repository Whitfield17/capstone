//
//  ChatBubble.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-29.
//

import SwiftUI

struct ChatBubble: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, isFromCurrentUser ? .bottomLeft : .bottomRight], cornerRadii: CGSize( width: 16, height: 16))
        return Path(path.cgPath)
    }
    
    var isFromCurrentUser: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
