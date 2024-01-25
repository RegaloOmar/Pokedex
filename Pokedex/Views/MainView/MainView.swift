//
//  MainView.swift
//  Pokedex
//
//  Created by Omar Regalado on 25/01/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("PokeDex", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    MainView()
}
