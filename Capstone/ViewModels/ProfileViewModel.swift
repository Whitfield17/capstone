//
//  ProfileViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-11-25.
//

import SwiftUI
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var favouritedBusinesses = [Business]()

    
    init(user: User) {
        self.user = user
        fetchFavouritedBusinesses()
    }
    
    func businesses() -> [Business] {
        return favouritedBusinesses
    }
    
}

// MARK: - API

extension ProfileViewModel {
    
    func fetchFavouritedBusinesses() {
        var businesses = [Business]()
        Constants.COLLECTION_USERS.document(user.id).collection("user-favourites").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
//            taking all the document ids from documents and storing them in tweetIDs
            let businessIDs = documents.map({ $0.documentID })
            
            businessIDs.forEach { id in
//                getting each tweet
                Constants.COLLECTION_BUSINESSES.document(id).getDocument { snapshot, _ in
                    guard let data = snapshot?.data() else { return }
                    let business = Business(dictionary: data)
                    businesses.append(business)
                    guard businesses.count == businessIDs.count else { return }
                    
                    self.favouritedBusinesses = businesses
                }
            }
        }
    }
}
