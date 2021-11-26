//
//  BusinessViewModel.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI
import Firebase
import CoreLocation

class BusinessViewModel: ObservableObject {
//    Keeps track of the user's business, will be set to load business data
    @Published var business: Business?
    
    @State private var latitude = 0.0
    @State private var longitude = 0.0
            
    //Fetch user business is running even when the user is not a business owner which causes the app to crash
    
    init() {
        //fetchUserBusiness()
    }
    
    //MARK: - Business Methods
    
    func uploadBusiness(businessName: String, description: String, websiteUrl: String, email: String, phoneNumber: String, address: String, city: String, province: String, openMonday: Bool, mondayStartTime: Date, mondayEndTime: Date, openTuesday: Bool, tuesdayStartTime: Date, tuesdayEndTime: Date, openWednesday: Bool, wednesdayStartTime: Date, wednesdayEndTime: Date, openThursday: Bool, thursdayStartTime: Date, thursdayEndTime: Date, openFriday: Bool, fridayStartTime: Date, fridayEndTime: Date, openSaturday: Bool, saturdayStartTime: Date, saturdayEndTime: Date, openSunday: Bool, sundayStartTime: Date, sundayEndTime: Date) {
        
        guard let user = AuthViewModel.shared.user else { return }
        let businessesDocRef = Constants.COLLECTION_BUSINESSES.document(user.businessId)
        
        //Get the latitude and longitude based off the given address string
        //TODO: - If These values are empty the business will not be uploaded at all
        getCoordinate(address: address, city: city, province: province) { (location, error) in
            
            if error == nil {
                //Add business data to businesses doc
                let businessData: [String: Any] = ["id": businessesDocRef.documentID,
                                           "ownerUid": user.id,
                                           "businessName": businessName,
                                           "description": description,
                                           "websiteUrl": websiteUrl,
                                           "email": email,
                                           "phoneNumber": phoneNumber,
                                           "address": address,
                                           "city": city,
                                           "province": province,
                                           "latitude": location.latitude,
                                           "longitude": location.longitude,
                                           "openMonday": openMonday,
                                           "mondayStartTime": mondayStartTime,
                                           "mondayEndTime": mondayEndTime,
                                           "openTuesday": openTuesday,
                                           "tuesdayStartTime": tuesdayStartTime,
                                           "tuesdayEndTime": tuesdayEndTime,
                                           "openWednesday": openWednesday,
                                           "wednesdayStartTime": wednesdayStartTime,
                                           "wednesdayEndTime": wednesdayEndTime,
                                           "openThursday": openThursday,
                                           "thursdayStartTime": thursdayStartTime,
                                           "thursdayEndTime": thursdayEndTime,
                                           "openFriday": openFriday,
                                           "fridayStartTime": fridayStartTime,
                                           "fridayEndTime": fridayEndTime,
                                           "openSaturday": openSaturday,
                                           "saturdayStartTime": saturdayStartTime,
                                           "saturdayEndTime": saturdayEndTime,
                                           "openSunday": openSunday,
                                           "sundayStartTime": sundayStartTime,
                                           "sundayEndTime": sundayEndTime]
                
                businessesDocRef.setData(businessData, merge: true) { (_) in
                    print("DEBUG: Successfully uploaded business")
                    self.fetchUserBusiness()
                }
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    func fetchUserBusiness() {
        guard let user = AuthViewModel.shared.user else { return }
        
//        Going into the users collection in Firestore, and finds the uid document for the current user
        Constants.COLLECTION_BUSINESSES.document(user.businessId).getDocument { [self] (snapshot, _) in
//            Getting the data returned back from Firestore
            guard let data = snapshot?.data() else { return }
            self.business = Business(dictionary: data)
            
            print("DEBUG: Successfully fetched business \(business?.businessName ?? "No name found")")
        }
    }
    
    func timestampFormatter(timestamp: Timestamp) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: timestamp.dateValue())
    }
    
    func getCoordinate(address: String, city: String, province: String, completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("\(address), \(city), \(province)") { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}
