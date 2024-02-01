//
//  ListView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \PokemonModel.id) var pokemonsModel: [PokemonModel]
    @StateObject private var viewModel = ListViewModel()
    @State private var isFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader(content: { geometry in
                let gridItemWidth = CGFloat((geometry.size.width / 2) - 5)
                let gridItem = GridItem(.fixed(gridItemWidth))
                ScrollView {
                    LazyVGrid(columns: [gridItem, gridItem]) {
                        ForEach(viewModel.pokemons) { pokemon in 
                            NavigationLink {
                                DetailsView(isFavorite: false, pokemon: pokemon)
                            } label: {
                                PokemonGrid(pokemon: pokemon,
                                            foregroundStyle: viewModel.getBackgroundColor(from: pokemon.types),
                                            gridItemWidth: gridItemWidth)
                            }
                        }
                    }
                    .onAppear {
                        Task {
                            await viewModel.fetchPokemonList()
                        }
                    }
                }
                .scrollIndicators(.hidden)
            })
            .padding(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .preferredColorScheme(.dark)
    }
}



struct PokemonGrid: View {
    var pokemon: PokemonData
    var foregroundStyle: Color
    var gridItemWidth: CGFloat
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.sprites.frontDefault))
            
            Text(pokemon.name.capitalized)
                .font(.system(.headline))
                .foregroundStyle(.white)
                .padding(.bottom)
        }
        .frame(width: gridItemWidth)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .foregroundStyle(foregroundStyle)
        }
    }
}
