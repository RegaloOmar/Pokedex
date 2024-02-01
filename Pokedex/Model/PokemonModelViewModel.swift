//
//  PokemonModelViewModel.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 01/02/24.
//

import Foundation
import SwiftData

@Observable
final class PokemonModelViewModel: ObservableObject {
    var pokemonsModel: [PokemonModel] = []
    let container = try! ModelContainer(for: PokemonModel.self)
    
    @MainActor
    var modelContext: ModelContext {
        container.mainContext
    }
    
    @MainActor
    func getSavedPokemons() {
        let fetchDescriptor = FetchDescriptor<PokemonModel>(predicate: nil,
                                                     sortBy: [SortDescriptor<PokemonModel>(\.id)])
        pokemonsModel = try! modelContext.fetch(fetchDescriptor)
        print(pokemonsModel)
    }
    
    @MainActor
    func deletePokemon() {
        pokemonsModel.forEach {
            modelContext.delete($0)
        }
        pokemonsModel = []
        getSavedPokemons()
    }
    
    @MainActor
    func insert(pokemon: PokemonModel) {
        modelContext.insert(pokemon)
        pokemonsModel = []
        getSavedPokemons()
    }
}
