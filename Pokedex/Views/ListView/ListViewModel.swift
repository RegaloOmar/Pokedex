//
//  ListViewModel.swift
//  Pokedex
//
//  Created by Omar Regalado on 25/01/24.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    
    @Published var pokemons: [PokemonData] = []
    @Published var error: Error?
    
    private let pokemonService: PokemonServiceManagerProtocol
    private var mainQueue = DispatchQueue.main
    private var next: String?
    private var previuos: String?
    
    init(pokemonService: PokemonServiceManager = PokemonServiceManager()) {
        self.pokemonService = pokemonService
    }
    
    func fetchPokemonList() async {
        do {
            let pokemonInfo = try await pokemonService.fetchPokemonData()
            mainQueue.async {[weak self] in
                guard let self = self else { return }
                self.pokemons = pokemonInfo.pokemons
                self.next = pokemonInfo.next
            }
        } catch {
            
        }
    }
    
    func fetchMorePokemons() async {
        do {
            guard let urlString = next else { return }
            let pokemonInfo = try await pokemonService.fetchMorePokemons(urlString: urlString)
            mainQueue.async {[weak self] in
                guard let self = self else { return }
                self.pokemons.append(contentsOf: pokemonInfo.pokemons)
                self.next = pokemonInfo.next
            }
        } catch {
            
        }
    }
    
    func getBackgroundColor(from pokemonTypes: [Types]) -> Color {
        guard let pokemonType = pokemonTypes.first else { return Color.gray}
        return TypeColors().getColor(from: pokemonType.type.name)
    }
}
