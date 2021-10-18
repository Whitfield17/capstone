//
//  EditBusinessView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct EditBusinessView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var businessViewModel: BusinessViewModel
        
    @State var businessName = ""
    @State var description = ""
    @State var websiteUrl = ""
    @State var email = ""
    @State var phoneNumber = ""
    @State var address = ""
    @State var city = ""
    @State var province = ""
    @State var latitude = 0.0
    @State var longitude = 0.0
    
    @State var openMonday = false
    @State var mondayStartTime = Date()
    @State var mondayEndTime = Date()
    @State var openTuesday = false
    @State var tuesdayStartTime = Date()
    @State var tuesdayEndTime = Date()
    @State var openWednesday = false
    @State var wednesdayStartTime = Date()
    @State var wednesdayEndTime = Date()
    @State var openThursday = false
    @State var thursdayStartTime = Date()
    @State var thursdayEndTime = Date()
    @State var openFriday = false
    @State var fridayStartTime = Date()
    @State var fridayEndTime = Date()
    @State var openSaturday = false
    @State var saturdayStartTime = Date()
    @State var saturdayEndTime = Date()
    @State var openSunday = false
    @State var sundayStartTime = Date()
    @State var sundayEndTime = Date()
    
    var body: some View {
        
        if businessViewModel.business != nil {
            VStack {
                HStack {
                    Spacer()
                    
                    Button { businessViewModel.uploadBusiness(businessName: businessName, description: description, websiteUrl: websiteUrl, email: email, phoneNumber: phoneNumber, address: address, city: city, province: province, openMonday: openMonday, mondayStartTime: mondayStartTime, mondayEndTime: mondayEndTime, openTuesday: openTuesday, tuesdayStartTime: tuesdayStartTime, tuesdayEndTime: tuesdayEndTime, openWednesday: openWednesday, wednesdayStartTime: wednesdayStartTime, wednesdayEndTime: wednesdayEndTime, openThursday: openThursday, thursdayStartTime: thursdayStartTime, thursdayEndTime: thursdayEndTime, openFriday: openFriday, fridayStartTime: fridayStartTime, fridayEndTime: fridayEndTime, openSaturday: openSaturday, saturdayStartTime: saturdayStartTime, saturdayEndTime: saturdayEndTime, openSunday: openSunday, sundayStartTime: sundayStartTime, sundayEndTime: sundayEndTime)
                    } label: {
                        Text("Save")
                    }
                }.padding()
                
                ScrollView {
                    VStack {
                        
                        TextField("Business Name", text: $businessName)
                            .onAppear {
                                self.businessName = businessViewModel.business?.businessName ?? ""
                            }
                        
                        TextArea("Description", text: $description)
                            .onAppear {
                                self.description = businessViewModel.business?.description ?? ""
                            }
                        
                        TextField("Address", text: $address)
                            .onAppear {
                                self.address = businessViewModel.business?.address ?? ""
                            }
                        
                        TextField("City", text: $city)
                            .onAppear {
                                self.city = businessViewModel.business?.city ?? ""
                            }
                        
                        TextField("Province", text: $province)
                            .onAppear {
                                self.province = businessViewModel.business?.province ?? ""
                            }
                        
                    }
                    .padding()
                    
                    VStack {
                        EditHoursView(day: "Monday", isOpen: $openMonday, startTime: $mondayStartTime, endTime: $mondayEndTime)
                            .onAppear {
                                self.openMonday = businessViewModel.business?.openMonday ?? false
                                self.mondayStartTime = businessViewModel.business?.mondayStartTime.dateValue() ?? Date()
                                self.mondayEndTime = businessViewModel.business?.mondayEndTime.dateValue() ?? Date()
                            }
                        
                        EditHoursView(day: "Tuesday", isOpen: $openTuesday, startTime: $tuesdayStartTime, endTime: $tuesdayEndTime)
                            .onAppear {
                                self.openTuesday = businessViewModel.business?.openTuesday ?? false
                                self.tuesdayStartTime = businessViewModel.business?.tuesdayStartTime.dateValue() ?? Date()
                                self.tuesdayEndTime = businessViewModel.business?.tuesdayEndTime.dateValue() ?? Date()
                            }
                        
                        EditHoursView(day: "Wednesday", isOpen: $openWednesday, startTime: $wednesdayStartTime, endTime: $wednesdayEndTime)
                            .onAppear {
                                self.openWednesday = businessViewModel.business?.openWednesday ?? false
                                self.wednesdayStartTime = businessViewModel.business?.wednesdayStartTime.dateValue() ?? Date()
                                self.wednesdayEndTime = businessViewModel.business?.wednesdayEndTime.dateValue() ?? Date()
                            }
                        
                        EditHoursView(day: "Thursday", isOpen: $openThursday, startTime: $thursdayStartTime, endTime: $thursdayEndTime)
                            .onAppear {
                                self.openThursday = businessViewModel.business?.openThursday ?? false
                                self.thursdayStartTime = businessViewModel.business?.thursdayStartTime.dateValue() ?? Date()
                                self.thursdayEndTime = businessViewModel.business?.thursdayEndTime.dateValue() ?? Date()
                            }
                        
                        EditHoursView(day: "Friday", isOpen: $openFriday, startTime: $fridayStartTime, endTime: $fridayEndTime)
                            .onAppear {
                                self.openFriday = businessViewModel.business?.openFriday ?? false
                                self.fridayStartTime = businessViewModel.business?.fridayStartTime.dateValue() ?? Date()
                                self.fridayEndTime = businessViewModel.business?.fridayEndTime.dateValue() ?? Date()
                            }
                        
                        EditHoursView(day: "Saturday", isOpen: $openSaturday, startTime: $saturdayStartTime, endTime: $saturdayEndTime)
                            .onAppear {
                                self.openSaturday = businessViewModel.business?.openSaturday ?? false
                                self.saturdayStartTime = businessViewModel.business?.saturdayStartTime.dateValue() ?? Date()
                                self.saturdayEndTime = businessViewModel.business?.saturdayEndTime.dateValue() ?? Date()
                            }
                        
                        EditHoursView(day: "Sunday", isOpen: $openSunday, startTime: $sundayStartTime, endTime: $sundayEndTime)
                            .onAppear {
                                self.openSunday = businessViewModel.business?.openSunday ?? false
                                self.sundayStartTime = businessViewModel.business?.sundayStartTime.dateValue() ?? Date()
                                self.sundayEndTime = businessViewModel.business?.sundayEndTime.dateValue() ?? Date()
                            }
                    }
                }
            }

        } else {
            //Waiting for data so show progress view
            ProgressView()
        }
    }
}
