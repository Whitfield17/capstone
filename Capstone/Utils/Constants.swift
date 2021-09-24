//
//  Constants.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI
import Firebase

struct Constants {
    
    static let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    static let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    static let usersCollection = Firestore.firestore().collection("users")
    static let businessesCollection = Firestore.firestore().collection("businesses")
    
    enum AccountType {
        case personal
        case business
    }
}
