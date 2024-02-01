//
//  FavoritesViewModel.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 30/01/24.
//

import Foundation
import SwiftUI

class FavoritesViewModel: ObservableObject {
    
    
    
    
    
    
    func getBackgroundColor(from pokemonTypes: [Types]) -> Color {
        guard let pokemonType = pokemonTypes.first else { return Color.gray}
        return TypeColors().getColor(from: pokemonType.type.name)
    }
}
