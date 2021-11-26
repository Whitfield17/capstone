//
//  InspectBusinessView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI
import Firebase

struct InspectBusinessView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var businessViewModel: BusinessViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text(businessViewModel.business?.businessName ?? "No name")
                
                HStack {
                    Text(businessViewModel.business?.address ?? "No address")
                    
                    Text(businessViewModel.business?.city ?? "No city")
                }
                
                Text(businessViewModel.business?.description ?? "No description")
                    .multilineTextAlignment(.center)
            }

            Divider()
            
            VStack {
                Text("Monday: \((businessViewModel.business?.openMonday ?? false) ? "\(mondayStartTime) - \(mondayEndTime)" : "Closed")")
                
                Text("Tuesday: \((businessViewModel.business?.openTuesday ?? false) ? "\(tuesdayStartTime) - \(tuesdayEndTime)" : "Closed")")
                
                Text("Wednesday: \((businessViewModel.business?.openWednesday ?? false) ? "\(wednesdayStartTime) - \(wednesdayEndTime)" : "Closed")")
                
                Text("Thursday: \((businessViewModel.business?.openThursday ?? false) ? "\(thursdayStartTime) - \(thursdayEndTime)" : "Closed")")
                
                Text("Friday: \((businessViewModel.business?.openFriday ?? false) ? "\(fridayStartTime) - \(fridayEndTime)" : "Closed")")
                
                Text("Saturday: \((businessViewModel.business?.openSaturday ?? false) ? "\(saturdayStartTime) - \(saturdayEndTime)" : "Closed")")
                
                Text("Sunday: \((businessViewModel.business?.openSunday ?? false) ? "\(sundayStartTime) - \(sundayEndTime)" : "Closed")")
            }
            
            Button {
                authViewModel.signOut()
            } label: {
                Text("Sign out")
            }
        }
        
        
    }
    
    //MARK: - Computed Properties
    
    var mondayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.mondayStartTime ?? Timestamp(date: Date()))
    }
    
    var mondayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.mondayEndTime ?? Timestamp(date: Date()))
    }
    
    var tuesdayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.tuesdayStartTime ?? Timestamp(date: Date()))
    }
    
    var tuesdayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.tuesdayEndTime ?? Timestamp(date: Date()))
    }
    
    var wednesdayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.wednesdayStartTime ?? Timestamp(date: Date()))
    }
    
    var wednesdayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.wednesdayEndTime ?? Timestamp(date: Date()))
    }
    
    var thursdayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.thursdayStartTime ?? Timestamp(date: Date()))
    }
    
    var thursdayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.thursdayEndTime ?? Timestamp(date: Date()))
    }
    
    var fridayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.fridayStartTime ?? Timestamp(date: Date()))
    }
    
    var fridayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.fridayEndTime ?? Timestamp(date: Date()))
    }
    
    var saturdayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.saturdayStartTime ?? Timestamp(date: Date()))
    }
    
    var saturdayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.saturdayEndTime ?? Timestamp(date: Date()))
    }
    
    var sundayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.sundayStartTime ?? Timestamp(date: Date()))
    }
    
    var sundayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: businessViewModel.business?.sundayEndTime ?? Timestamp(date: Date()))
    }
}


