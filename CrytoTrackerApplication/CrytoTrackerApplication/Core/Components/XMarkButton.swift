//
//  XMarkButton.swift
//  CrytoTrackerApplication
//
//  Created by Chandru Kumaran on 2024-04-08.
//

import SwiftUI


struct XMarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}


#Preview {
    XMarkButton()
}
