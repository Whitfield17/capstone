//
//  BusinessDetailViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-30.
//

import SwiftUI
import Firebase

class BusinessDetailViewModel: ObservableObject {
    @Published var user: User?
    
    func fetchBusinessOwner(withOwnerUid ownerUid: String) {
        
//        Going into the users collection in Firestore, and finds the uid document for the current user
        Firestore.firestore().collection("users").document(ownerUid).getDocument { (snapshot, _) in
//            Getting the data returned back from Firestore
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
            
            print("DEBUG: Business owner id \(self.user?.id ?? "Nope")")

        }
    }
}
