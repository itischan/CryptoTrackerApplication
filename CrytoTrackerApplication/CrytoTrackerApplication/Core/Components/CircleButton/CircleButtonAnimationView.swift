//
//  CircleButtonAnimationView.swift
//  SwiftfulCrypto
//
//  Created by Chandru Kumaran on 2/11/24
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 1.0): .none)
//            .stroke(lineWidth: 5.0)
//            .scale(animate ? 1.0 : 0.0)
//            .opacity(animate ? 0.0 : 1.0)
//            .animation(animate ? Animation.easeOut(duration: 1.0) : .none)
    }
}

#Preview{
    CircleButtonAnimationView(animate: .constant(true))
        .foregroundColor(.red)
        .frame(width: 100, height: 100)
}

