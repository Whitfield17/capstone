//
//  BusinessListViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-23.
//

import SwiftUI
import Firebase

class BusinessListViewModel: ObservableObject {
    @Published var businesses = [Business]()
    
    init() {
        fetchBusinesses()
    }
    
    func fetchBusinesses() {
        Firestore.firestore().collection("businesses").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = snapshot?.documents else { return }
                self.businesses = documents.map({ Business(dictionary: $0.data()) })
            }
        }
    }
}
