//
//  MainView.swift
//  Pokedex
//
//  Created by Omar Regalado on 25/01/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            TabView {
                ListView()
                    .tabItem {
                        Label("PokeDex", systemImage: "list.dash")
                    }
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
            }
        }
    }
}

#Preview {
    MainView()
}
