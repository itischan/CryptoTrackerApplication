//
//  NavigationLazyView.swift
//  CrytoTrackerApplication
//
//  Created by Ajai Jacob on 2024-03-04.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

//#Preview {
//    NavigationLazyView()
//}
