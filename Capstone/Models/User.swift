//
//  User.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import Firebase

struct User: Identifiable {
    
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let accountType: String
    let businessId: String
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == self.id }
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? String ?? ""
        self.businessId = dictionary["businessId"] as? String ?? ""
    }
}
