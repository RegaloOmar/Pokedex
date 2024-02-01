//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import SwiftUI
import SwiftData

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [PokemonModel.self])
    }
}
