//
//  Colors.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 30/01/24.
//

import Foundation
import SwiftUI

struct TypeColors {
    
    public func getColor(from pokemonType: String) -> Color {
        switch pokemonType {
            case "normal":
                return Color("pokemonNormal", bundle: nil)
            case "fire":
                return Color("pokemonFire", bundle: nil)
            case "water":
                return Color("pokemonWater", bundle: nil)
            case "electric":
                return Color("pokemonElectric", bundle: nil)
            case "grass":
                return Color("pokemonGrass", bundle: nil)
            case "ice":
                return Color("pokemonIce", bundle: nil)
            case "fighting":
                return Color("pokemonFighting", bundle: nil)
            case "poison":
                return Color("pokemonPoison", bundle: nil)
            case "ground":
                return Color("pokemonGround", bundle: nil)
            case "flying":
                return Color("pokemonFlying", bundle: nil)
            case "psychic":
                return Color("pokemonPsychic", bundle: nil)
            case "bug":
                return Color("pokemonBug", bundle: nil)
            case "rock":
                return Color("pokemonRock", bundle: nil)
            case "ghost":
                return Color("pokemonGhost", bundle: nil)
            case "dragon":
                return Color("pokemonDragon", bundle: nil)
            case "dark":
                return Color("pokemonDark", bundle: nil)
            case "steel":
                return Color("pokemonSteel", bundle: nil)
            case "fairy":
                return Color("pokemonFairy", bundle: nil)
            default:
                return Color("pokemonNormal", bundle: nil)
        }
    }
    
}
