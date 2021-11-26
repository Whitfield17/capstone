//
//  BusinessDetailViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-30.
//

import SwiftUI
import Firebase

class BusinessDetailViewModel: ObservableObject {
    let business: Business
    @Published var didFavourite = false
    @Published var user: User?
    @Published var ratingValue = 0
    @Published var averageRating = 0.0
    
    init(business: Business) {
        self.business = business
        checkIfUserFavouritedBusiness()
        checkIfUserRatedBusiness()
        calculateRating()
    }
    
    //Count number of documents in the business-ratings sub collection
    //Get the sum of the rating field from each document
    //Pass to published var to be used in the view
    func calculateRating() {
        var ratingTotal = 0
        var numberOfRatings = 0
        var ratingDictionary = [String: Any]()
        var averageRating = 0.0
        
        Constants.COLLECTION_BUSINESSES.document(business.id).collection("business-ratings").getDocuments { (snapshot, _) in
            guard let documents = snapshot?.documents else { return }

            for doc in documents {
                ratingDictionary = doc.data()
                ratingTotal = ratingTotal + (ratingDictionary["rating"] as! Int)
                //let rating: Int? = ratingDictionary["rating"]
                print("DEBUG: \(ratingDictionary["rating"] ?? 0)")
            }
            
            /*
            for document in snapshot!.documents {
                print("DEBUG: \(document.documentID) => \(document.data())")
                test = document.data()
                print("DEBUG: \(test["rating"])")
            }
            
            guard let documents = snapshot?.documents else { return }
            //let userIDs = documents.map({ $0.documentID })
                */
            numberOfRatings = documents.count
            print("DEBUG: \(numberOfRatings)")
            
            if (numberOfRatings > 0) {
                averageRating = Double(ratingTotal / numberOfRatings)
                self.averageRating = round(averageRating * 10) / 10.0
            } 

            //Loop through each document and sum up the rating field
            //documents.forEach { doc in
                //ratingTotal = ratingTotal + doc.data()
            //}
            
            
        }
        

    }
    
    
    func rateBusiness(value: Int) {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let businessRatingsRef = Constants.COLLECTION_BUSINESSES.document(business.id).collection("business-ratings")
        let userRatingsRef = Constants.COLLECTION_USERS.document(uid).collection("user-ratings")
        
        Constants.COLLECTION_BUSINESSES.document(business.id).updateData(["ratings" : business.ratings + 1]) { (_) in
            businessRatingsRef.document(uid).setData(["rating" : value]) { (_) in
                userRatingsRef.document(self.business.id).setData(["rating" : value]) { (_) in
                    self.ratingValue = value
                }
            }
        }
    }
    
    func unrateBusiness(value: Int) {
        
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        reference the users that have liked the current tweet
        let businessRatingsRef = Constants.COLLECTION_BUSINESSES.document(business.id).collection("business-ratings")
//        Reference the current users' liked tweets
        let userRatingsRef = Constants.COLLECTION_USERS.document(uid).collection("user-ratings")
        
        Constants.COLLECTION_BUSINESSES.document(business.id).updateData(["ratings" : business.ratings - 1]) { (_) in
            businessRatingsRef.document(uid).delete { (_) in
                userRatingsRef.document(self.business.id).delete { (_) in
                    self.ratingValue = 0
                }
            }
        }
    }
    
    func checkIfUserRatedBusiness() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let userRatingsRef = Constants.COLLECTION_USERS.document(uid).collection("user-ratings").document(business.id)

        userRatingsRef.getDocument { snapshot, _ in
            if let snapshot = snapshot {
                self.ratingValue = snapshot.get("rating") as? Int ?? 0
            }            
        }
    }
    
    func favouriteBusiness() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let businessFavouritesRef = Constants.COLLECTION_BUSINESSES.document(business.id).collection("business-favourites")
        let userFavouritesRef = Constants.COLLECTION_USERS.document(uid).collection("user-favourites")
        
//        Goes into the tweets collection, finds the selected tweet using its id, updates the likes field of the tweet
        Constants.COLLECTION_BUSINESSES.document(business.id).updateData(["favourites" : business.favourites + 1]) { (_) in
            businessFavouritesRef.document(uid).setData([:]) { (_) in
                userFavouritesRef.document(self.business.id).setData([:]) { (_) in
                    self.didFavourite = true
                }
            }
        }
    }
    
    func unfavouriteBusiness() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        reference the users that have liked the current tweet
        let businessFavouritesRef = Constants.COLLECTION_BUSINESSES.document(business.id).collection("business-favourites")
//        Reference the current users' liked tweets
        let userFavouritesRef = Constants.COLLECTION_USERS.document(uid).collection("user-favourites")
        
        Constants.COLLECTION_BUSINESSES.document(business.id).updateData(["favourites" : business.favourites - 1]) { (_) in
            businessFavouritesRef.document(uid).delete { (_) in
                userFavouritesRef.document(self.business.id).delete { (_) in
                    self.didFavourite = false
                }
            }
        }
    }
    
    func checkIfUserFavouritedBusiness() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        let userFavouritesRef = Constants.COLLECTION_USERS.document(uid).collection("user-favourites").document(business.id)

        userFavouritesRef.getDocument { snapshot, _ in
            guard let didFavourite = snapshot?.exists else { return }
            self.didFavourite = didFavourite
        }
    }
    
    func fetchBusinessOwner(withOwnerUid ownerUid: String) {
        
//        Going into the users collection in Firestore, and finds the uid document for the current user
        Firestore.firestore().collection("users").document(ownerUid).getDocument { (snapshot, _) in
//            Getting the data returned back from Firestore
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
            
        }
    }
}
