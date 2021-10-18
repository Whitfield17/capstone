//
//  BusinessListView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct BusinessListView: View {
    @ObservedObject var businessListViewModel = BusinessListViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(businessListViewModel.businesses) { business in
                    NavigationLink(
                        destination: BusinessDetailView(business: business),
                        label: {
                            BusinessCell(business: business)
                        }).foregroundColor(.black)
                }
            }
            .padding()
        }
    }
}
