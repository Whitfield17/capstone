//
//  BusinessListView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-09-14.
//

import SwiftUI

struct BusinessListView: View {
    @State var searchText = ""
    @ObservedObject var searchViewModel = SearchViewModel()
    //@ObservedObject var businessListViewModel = BusinessListViewModel()
    
    var body: some View {
        ScrollView {
            SearchBar(text: $searchText)
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(searchText.isEmpty ? searchViewModel.businesses : searchViewModel.filteredBusinesses(searchText)) { business in
                    HStack { Spacer() }
                    
                    NavigationLink(
                        destination: LazyView(BusinessDetailView(business: business)),
                        label: { BusinessCell(business: business) }).foregroundColor(.black)
                }
            }.padding(.leading)
        }
    }
}
