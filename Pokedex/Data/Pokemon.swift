//
//  Pokemon.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import Foundation

struct RootInfo: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonList]
}

struct Pokemon: Codable {
    let abilities: Ability
}

struct PokemonList: Codable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
}

struct Ability: Codable {
    let name: String
    let url: String
    let isHidden: Bool
    let slot: Int
}
