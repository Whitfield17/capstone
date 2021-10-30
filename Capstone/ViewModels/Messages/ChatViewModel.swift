//
//  ChatViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-29.
//

import SwiftUI
import Firebase

class ChatViewModel: ObservableObject {
//    ViewModel should always own an instance of our model
    let user: User
    @Published var messages = [Message]()
    
    init(user: User) {
        self.user = user
        fetchMessages()
    }
    
    func fetchMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = Constants.COLLECTION_MESSAGES.document(uid).collection(user.id)
        
//        Adds a listener on our database that keeps track of whenever the structure gets changed
        query.addSnapshotListener { (snapshot, error) in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            
            changes.forEach { (change) in
                let messageData = change.document.data()
                guard let fromId = messageData["fromId"] as? String else { return }
                
                Constants.COLLECTION_USERS.document(fromId).getDocument { (snapshot, _) in
                    guard let data = snapshot?.data() else { return }
                    let user = User(dictionary: data)
                    self.messages.append(Message(user: user, dictionary: messageData))
//                    Sorts messages with most recent at the bottom
                    self.messages.sort(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() })
                }
            }
        }
    }
    
    func sendMessage(_ messageText: String) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        let currentUserRef = Constants.COLLECTION_MESSAGES.document(currentUid).collection(user.id).document()
        let receivingUserRef = Constants.COLLECTION_MESSAGES.document(user.id).collection(currentUid)
        let receivingRecentRef = Constants.COLLECTION_MESSAGES.document(user.id).collection("recent-messages")
        let currentRecentRef = Constants.COLLECTION_MESSAGES.document(currentUid).collection("recent-messages")
        let messageID = currentUserRef.documentID
        
        let data: [String: Any] = ["text": messageText,
                                    "id": messageID,
                                    "fromId": currentUid,
                                    "toId": user.id,
                                    "timestamp": Timestamp(date: Date())]
        
        currentUserRef.setData(data)
        receivingUserRef.document(messageID).setData(data)
        receivingRecentRef.document(currentUid).setData(data)
        currentRecentRef.document(user.id).setData(data)
    }
}
