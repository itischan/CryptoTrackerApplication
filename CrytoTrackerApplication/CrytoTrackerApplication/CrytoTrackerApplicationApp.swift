//
//  CrytoTrackerApplicationApp.swift
//  CrytoTrackerApplication
//
//  Created by ck on 2024-01-23.
//

import SwiftUI

@main
struct CrytoTrackerApplicationApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomeView()
                    
            }.environmentObject(vm)
            
        }
    }
}
