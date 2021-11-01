//
//  LazyView.swift
//  Capstone
//
//  Created by Braydon Whitfield on 2021-11-01.
//

import SwiftUI

import SwiftUI

// Only loads data as it is needed to
struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: some View {
        build()
    }
}
