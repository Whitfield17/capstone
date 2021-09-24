//
//  EditHoursView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI
import Firebase

struct EditHoursView: View {
    
    var day: String
    @Binding var isOpen: Bool
    @Binding var startTime: Date
    @Binding var endTime: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(day):")
                
                Toggle(isOpen ? "Open" : "Closed", isOn: $isOpen)
            }
            
            HStack {
                if isOpen {
                    DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                    Text(" - ")
                    
                    DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
        }
        .padding()
    }
}
