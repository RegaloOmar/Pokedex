//
//  DetailsViewModel.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 01/02/24.
//

import Foundation
import SwiftUI

class DetailsViewModel: ObservableObject {
    
    func getBackgroundColor(from pokemonTypes: Types) -> Color {
        return TypeColors().getColor(from: pokemonTypes.type.name.lowercased())
    }
}
