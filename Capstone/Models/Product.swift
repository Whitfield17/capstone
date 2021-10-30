//
//  Product.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-18.
//

import Firebase

struct Product: Identifiable {
    
    let id: String
    let name: String
    let description: String
    let price: String
        
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
    }
}
