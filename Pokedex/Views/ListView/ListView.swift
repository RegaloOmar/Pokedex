//
//  ListView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        List(viewModel.PokemonList) { pokemon in
            Text(pokemon.name)
        }
        .listStyle(.plain)
        .onAppear(perform: {
            Task {
                await viewModel.fetchPokemonList()
            }
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
