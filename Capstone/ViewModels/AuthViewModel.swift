//
//  AuthViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
//    Keeps track of whether or not the user is logged in
    @Published var userSession: FirebaseAuth.User?
//    Keeps track of whether or not the process of logging in or signing up is ongoing
    @Published var isAuthenticating = false
//    If we get an error when the user logs in we are going to set this error then show an alert message to the user
    @Published var error: Error?
//    Keeps track of the user, will be set to load user data
    @Published var user: User?
    
//    Shared instance of AuthViewModel is used to access the user wherever we want in the application without having
//    to reinstantiate the AuthViewModel
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    //MARK: - Authentication Methods
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to login: \(error.localizedDescription)")
                return
            }
                        
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    func registerUser(email: String, password: String, firstName: String, lastName: String, accountType: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                return
            }
            
//                    Getting the user from the result of createUser
            guard let user = result?.user else { return }
            
            if accountType == "Personal" {
                let data = ["email": email,
                            "firstName": firstName,
                            "lastName": lastName,
                            "accountType": accountType,
                            "uid": user.uid]
                
                Firestore.firestore().collection("users").document(user.uid).setData(data) { (_) in
                    self.userSession = user
                    self.fetchUser()
                }
            } else {
                let businessesDocRef = Constants.businessesCollection.document()
                
                let data = ["email": email,
                            "firstName": firstName,
                            "lastName": lastName,
                            "accountType": accountType,
                            "uid": user.uid,
                            "businessId": businessesDocRef.documentID]
                
                Firestore.firestore().collection("users").document(user.uid).setData(data) { (_) in
                    self.userSession = user
                    self.fetchUser()
                    
                    let data = ["id": businessesDocRef.documentID]
                    
                    Firestore.firestore().collection("businesses").document(businessesDocRef.documentID).setData(data) { (_) in
                        
                    }
                }
            }
        }
    }
    
    func signOut() {
        userSession = nil
        user = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
//        Going into the users collection in Firestore, and finds the uid document for the current user
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, _) in
//            Getting the data returned back from Firestore
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
            
            print("DEBUG: Signed in as \(self.user?.firstName ?? "Nope")")
            print("DEBUG: With account type \(self.user?.accountType ?? "Account type not found")")

        }
    }
    
    func personalAccountTabs(forIndex index: Int) -> String {
        switch index {
        case 0: return "Profile"
        case 1: return "List"
        case 2: return "Map"
        case 3: return "Messages"
        default: return ""
        }
    }
    
    func businessAccountTabs(forIndex index: Int) -> String {
        switch index {
        case 0: return "My Store"
        case 1: return "Edit Store"
        case 2: return "Messages"
        default: return ""
        }
    }
}
