//
//  Pokemon.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import Foundation

struct Pokemon {
    
}

struct Results {
    let name: String
    let url: String
}

struct PokeList {
    let count: Int
    let next: String
    let previous: String
    let results: [Results]
}
