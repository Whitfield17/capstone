//
//  SearchViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-11-25.
//

import SwiftUI
import Firebase

class SearchViewModel: ObservableObject {
    @Published var businesses = [Business]()
    
    init() {
        fetchBusinesses()
    }
    
//    Fetches all the businesses in our application
    func fetchBusinesses() {
        Constants.COLLECTION_BUSINESSES.getDocuments { (snapshot, _) in
            guard let documents = snapshot?.documents else { return }
            let businesses = documents.map({ Business(dictionary: $0.data()) })
            
            self.businesses = businesses
        }
    }
    
    func filteredBusinesses(_ query: String) -> [Business] {
        let lowercasedQuery = query.lowercased()
        return businesses.filter({ $0.businessName.lowercased().contains(lowercasedQuery) })
    }
    

}
