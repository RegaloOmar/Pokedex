//
//  ListViewModel.swift
//  Pokedex
//
//  Created by Omar Regalado on 25/01/24.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var PokemonList: [PokemonList] = []
    
    private let pokemonService: PokemonServiceManagerProtocol
    private var mainQueue = DispatchQueue.main
    private var next: String?
    private var previuos: String?
    
    init(pokemonService: PokemonServiceManager = PokemonServiceManager()) {
        self.pokemonService = pokemonService
    }
    
    func fetchPokemonList() async {
        do {
            let rootInfo = try await pokemonService.fetchPokemonList()
            mainQueue.async { [weak self] in
                guard let self = self else { return }
                
                self.PokemonList = rootInfo.results
                self.next = rootInfo.next
                self.previuos = rootInfo.previous
            }
        } catch {
            mainQueue.async { [weak self] in
                
            }
        }
    }
}
