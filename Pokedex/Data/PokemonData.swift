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

struct PokemonData: Codable, Identifiable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let isDefault: Bool
    let abilities: [Abilities]
    let sprites: Sprites
    let types: [Types]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseExperience = "base_experience"
        case height
        case isDefault = "is_default"
        case abilities
        case sprites
        case types
    }
}

struct PokemonList: Codable, Hashable{
    let name: String
    let url: String
}

struct Abilities: Codable, Hashable {
    let isHidden: Bool
    let slot: Int
    let ability: PokemonList
    
    enum CodingKeys: String, CodingKey {
        case isHidden = "is_hidden"
        case slot
        case ability
    }
}

struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Types: Codable, Hashable {
    let slot: Int
    let type: PokemonList
}

