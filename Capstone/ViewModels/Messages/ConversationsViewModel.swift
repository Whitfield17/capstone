//
//  ConversationsViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-29.
//

import SwiftUI

class ConversationsViewModel: ObservableObject {
    @Published var recentMessages = [Message]()
    private var recentMessagesDictionary = [String: Message]()
    
    init() {
        fetchRecentMessages()
    }
    
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = Constants.COLLECTION_MESSAGES.document(uid).collection("recent-messages")
//        Orders recent messages with most recent at the top
        query.order(by: "timestamp", descending: true)
        
//        Adds a listener on our database that keeps track of whenever the structure gets changed
        query.addSnapshotListener { (snapshot, error) in
            guard let changes = snapshot?.documentChanges else { return }
            
            changes.forEach { (change) in
                let messageData = change.document.data()
                let uid = change.document.documentID
                
                Constants.COLLECTION_USERS.document(uid).getDocument { (snapshot, _) in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.recentMessagesDictionary[uid] = Message(user: user, dictionary: messageData)
                    self.recentMessages = Array(self.recentMessagesDictionary.values)
                }
            }
        }
    }
}
