//
//  ProgressView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 01/02/24.
//

import SwiftUI

struct ProgressView: View {
    @State private var isAnimating = false
    
    var body: some View {
        Image("pokeball")
            .resizable()
            .frame(width: 150, height: 150)
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear() {
                isAnimating = true
            }
            .onDisappear() {
                isAnimating = false
            }
    }
}

#Preview {
    ProgressView()
}
