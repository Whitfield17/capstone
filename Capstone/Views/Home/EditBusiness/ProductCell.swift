//
//  ProductCell.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-10-18.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    
    var body: some View {
        VStack {
            Text(product.name)
        }
    }
}
