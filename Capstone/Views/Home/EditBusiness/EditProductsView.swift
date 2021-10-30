//
//  EditProductsView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-18.
//

import SwiftUI

struct EditProductsView: View {
    
    let data = (1...10).map { "Item \($0)" }
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(data, id: \.self) { item in

                    Text(item)
                }
            }
            .padding(.horizontal)
        }
    }
}
