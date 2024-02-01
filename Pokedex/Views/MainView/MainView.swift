//
//  MainView.swift
//  Pokedex
//
//  Created by Omar Regalado on 25/01/24.
//

import SwiftUI

struct MainView: View {
    
    @Environment(PokemonModelViewModel.self) var pokemonsModel 
    
    var body: some View {
        NavigationStack {
            TabView {
                ListView()
                    .environmentObject(pokemonsModel)
                    .tabItem {
                        Label("PokeDex", systemImage: "list.dash")
                    }
                
                FavoritesView()
                    .environmentObject(pokemonsModel)
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
