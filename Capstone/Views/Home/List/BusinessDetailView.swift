//
//  BusinessDetailView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-23.
//

import SwiftUI
import Firebase

struct BusinessDetailView: View {
    @ObservedObject var businessDetailViewModel: BusinessDetailViewModel
    @ObservedObject var businessViewModel = BusinessViewModel()

    @State var showChat = false
    let business: Business
    var user: User?
    var ownerUid: String?
    
    init(business: Business) {
        self.business = business
        self.businessDetailViewModel = BusinessDetailViewModel(business: business)
    }
    
    var body: some View {
        if let user = businessDetailViewModel.user {
            NavigationLink(destination: ChatView(user: user),
                           isActive: $showChat,
                           label: { })
        }
        
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack (alignment: .leading, spacing: 4) {

                    Text(business.businessName)
                    
                    HStack {
                        Text(business.address)
                        
                        Text(business.city)
                    }
                    
                    Text(business.description)
                        .multilineTextAlignment(.center)
                                        
                    HStack(spacing: 8) {
                        Button(action: {
                            businessDetailViewModel.didFavourite ? businessDetailViewModel.unfavouriteBusiness() : businessDetailViewModel.favouriteBusiness()
                        }, label: {
                            Image(systemName: businessDetailViewModel.didFavourite ? "heart.fill" : "heart")
                                .font(.system(size: 16))
                                .frame(width: 32, height: 32)
                                .foregroundColor(businessDetailViewModel.didFavourite ? .red : .gray)
                        })
                        
                        Spacer()
                        
                        //Need to only be able to select a button if ratingValue is the same value as the button, or zero
                        Button(action: {
                            if (businessDetailViewModel.ratingValue == 0) {
                                businessDetailViewModel.rateBusiness(value: 1)
                            } else if (businessDetailViewModel.ratingValue == 1) {
                                businessDetailViewModel.unrateBusiness(value: 1)
                            } else {
                                print("DEBUG: \(businessDetailViewModel.ratingValue)")
                            }
                        }, label: {
                            Image(systemName: "1.circle")
                                .font(.system(size: 16))
                                .frame(width: 32, height: 32)
                                .foregroundColor(businessDetailViewModel.ratingValue == 1 ? .red : .gray)
                        })
                        
                        Button(action: {
                            if (businessDetailViewModel.ratingValue == 0) {
                                businessDetailViewModel.rateBusiness(value: 2)
                            } else if (businessDetailViewModel.ratingValue == 2) {
                                businessDetailViewModel.unrateBusiness(value: 2)
                            }
                        }, label: {
                            Image(systemName: "2.circle")
                                .font(.system(size: 16))
                                .frame(width: 32, height: 32)
                                .foregroundColor(businessDetailViewModel.ratingValue == 2 ? .red : .gray)
                        })
                        
                        Button(action: {
                            if (businessDetailViewModel.ratingValue == 0) {
                                businessDetailViewModel.rateBusiness(value: 3)
                            } else if (businessDetailViewModel.ratingValue == 3) {
                                businessDetailViewModel.unrateBusiness(value: 3)
                            }
                        }, label: {
                            Image(systemName: "3.circle")
                                .font(.system(size: 16))
                                .frame(width: 32, height: 32)
                                .foregroundColor(businessDetailViewModel.ratingValue == 3 ? .red : .gray)
                        })
                        
                        Button(action: {
                            if (businessDetailViewModel.ratingValue == 0) {
                                businessDetailViewModel.rateBusiness(value: 4)
                            } else if (businessDetailViewModel.ratingValue == 4) {
                                businessDetailViewModel.unrateBusiness(value: 4)
                            }
                        }, label: {
                            Image(systemName: "4.circle")
                                .font(.system(size: 16))
                                .frame(width: 32, height: 32)
                                .foregroundColor(businessDetailViewModel.ratingValue == 4 ? .red : .gray)
                        })
                        
                        Button(action: {
                            if (businessDetailViewModel.ratingValue == 0) {
                                businessDetailViewModel.rateBusiness(value: 5)
                            } else if (businessDetailViewModel.ratingValue == 5) {
                                businessDetailViewModel.unrateBusiness(value: 5)
                            }
                        }, label: {
                            Image(systemName: "5.circle")
                                .font(.system(size: 16))
                                .frame(width: 32, height: 32)
                                .foregroundColor(businessDetailViewModel.ratingValue == 5 ? .red : .gray)
                        })
                        
                        
                    }//.padding()
                    
                    Text(businessDetailViewModel.averageRating > 0 ? "Rating: \(businessDetailViewModel.averageRating)" : "No ratings")
                                            
                }.padding()
                
                Divider()
                
                VStack {
                    Text("Monday: \((business.openMonday == true) ? "\(mondayStartTime) - \(mondayEndTime)" : "Closed")")
                    
                    Text("Tuesday: \((business.openTuesday == true) ? "\(tuesdayStartTime) - \(tuesdayEndTime)" : "Closed")")
                    
                    Text("Wednesday: \((business.openWednesday == true) ? "\(wednesdayStartTime) - \(wednesdayEndTime)" : "Closed")")
                    
                    Text("Thursday: \((business.openThursday == true) ? "\(thursdayStartTime) - \(thursdayEndTime)" : "Closed")")
                    
                    Text("Friday: \((business.openFriday == true) ? "\(fridayStartTime) - \(fridayEndTime)" : "Closed")")
                    
                    Text("Saturday: \((business.openSaturday == true) ? "\(saturdayStartTime) - \(saturdayEndTime)" : "Closed")")
                    
                    Text("Sunday: \((business.openSunday == true) ? "\(sundayStartTime) - \(sundayEndTime)" : "Closed")")
                }
                
                //Spacer()
                    
            }
            
            //Making the floating button
            Button(action: {
                businessDetailViewModel.fetchBusinessOwner(withOwnerUid: business.ownerUid);
                self.showChat.toggle()
            }, label: {
                Image(systemName: "message")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
        }
    }
    
    //MARK: - Computed Properties
    
    var mondayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.mondayStartTime)
    }
    
    var mondayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.mondayEndTime)
    }
    
    var tuesdayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.tuesdayStartTime)
    }
    
    var tuesdayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.tuesdayEndTime)
    }
    
    var wednesdayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.wednesdayStartTime)
    }
    
    var wednesdayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.wednesdayEndTime)
    }
    
    var thursdayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.thursdayStartTime)
    }
    
    var thursdayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.thursdayEndTime)
    }
    
    var fridayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.fridayStartTime)
    }
    
    var fridayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.fridayEndTime)
    }
    
    var saturdayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.saturdayStartTime)
    }
    
    var saturdayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.saturdayEndTime)
    }
    
    var sundayStartTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.sundayStartTime)
    }
    
    var sundayEndTime: String {
        return businessViewModel.timestampFormatter(timestamp: business.sundayEndTime)
    }
    
}

