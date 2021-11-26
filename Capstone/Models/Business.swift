//
//  Business.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import Foundation
import Firebase

class Business: Identifiable, ObservableObject {
    
    let id: String
    let ownerUid: String
    let businessName: String
    let description: String
    let websiteUrl: String
    let email: String
    let phoneNumber: String
    let address: String
    let city: String
    let province: String
    let latitude: Double
    let longitude: Double
    
    let favourites: Int
    let ratings: Int
    
    //let products: [Product]
    
    let openMonday: Bool
    let mondayStartTime: Timestamp
    let mondayEndTime: Timestamp
    let openTuesday: Bool
    let tuesdayStartTime: Timestamp
    let tuesdayEndTime: Timestamp
    let openWednesday: Bool
    let wednesdayStartTime: Timestamp
    let wednesdayEndTime: Timestamp
    let openThursday: Bool
    let thursdayStartTime: Timestamp
    let thursdayEndTime: Timestamp
    let openFriday: Bool
    let fridayStartTime: Timestamp
    let fridayEndTime: Timestamp
    let openSaturday: Bool
    let saturdayStartTime: Timestamp
    let saturdayEndTime: Timestamp
    let openSunday: Bool
    let sundayStartTime: Timestamp
    let sundayEndTime: Timestamp
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.businessName = dictionary["businessName"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.websiteUrl = dictionary["websiteUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.city = dictionary["city"] as? String ?? ""
        self.province = dictionary["province"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? Double ?? 0
        self.longitude = dictionary["longitude"] as? Double ?? 0
        
        self.openMonday = dictionary["openMonday"] as? Bool ?? false
        self.mondayStartTime = dictionary["mondayStartTime"] as? Timestamp ?? Timestamp(date: Date())
        self.mondayEndTime = dictionary["mondayEndTime"] as? Timestamp ?? Timestamp(date: Date())
        self.openTuesday = dictionary["openTuesday"] as? Bool ?? false
        self.tuesdayStartTime = dictionary["tuesdayStartTime"] as? Timestamp ?? Timestamp(date: Date())
        self.tuesdayEndTime = dictionary["tuesdayEndTime"] as? Timestamp ?? Timestamp(date: Date())
        self.openWednesday = dictionary["openWednesday"] as? Bool ?? false
        self.wednesdayStartTime = dictionary["wednesdayStartTime"] as? Timestamp ?? Timestamp(date: Date())
        self.wednesdayEndTime = dictionary["wednesdayEndTime"] as? Timestamp ?? Timestamp(date: Date())
        self.openThursday = dictionary["openThursday"] as? Bool ?? false
        self.thursdayStartTime = dictionary["thursdayStartTime"] as? Timestamp ?? Timestamp(date: Date())
        self.thursdayEndTime = dictionary["thursdayEndTime"] as? Timestamp ?? Timestamp(date: Date())
        self.openFriday = dictionary["openFriday"] as? Bool ?? false
        self.fridayStartTime = dictionary["fridayStartTime"] as? Timestamp ?? Timestamp(date: Date())
        self.fridayEndTime = dictionary["fridayEndTime"] as? Timestamp ?? Timestamp(date: Date())
        self.openSaturday = dictionary["openSaturday"] as? Bool ?? false
        self.saturdayStartTime = dictionary["saturdayStartTime"] as? Timestamp ?? Timestamp(date: Date())
        self.saturdayEndTime = dictionary["saturdayEndTime"] as? Timestamp ?? Timestamp(date: Date())
        self.openSunday = dictionary["openSunday"] as? Bool ?? false
        self.sundayStartTime = dictionary["sundayStartTime"] as? Timestamp ?? Timestamp(date: Date())
        self.sundayEndTime = dictionary["sundayEndTime"] as? Timestamp ?? Timestamp(date: Date())
        
        self.favourites = dictionary["favourites"] as? Int ?? 0
        self.ratings = dictionary["ratings"] as? Int ?? 0
    }
}
