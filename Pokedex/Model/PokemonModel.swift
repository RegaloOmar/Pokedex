//
//  PokemonData.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 30/01/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class PokemonModel {
    
    @Attribute(.unique) var id: Int
    var name: String
    var baseExperience: Int
    var height: Int
    var sprites: Sprites
    var abilities: [Abilities]
    var types: [Types]
    var isFavorite: Bool
    
    init(id: Int, name: String, baseExperience: Int, height: Int, sprites: Sprites, abilities: [Abilities], types: [Types], isFavorite: Bool) {
        self.id = id
        self.name = name
        self.baseExperience = baseExperience
        self.height = height
        self.sprites = sprites
        self.abilities = abilities
        self.types = types
        self.isFavorite = isFavorite
    }
    
}
