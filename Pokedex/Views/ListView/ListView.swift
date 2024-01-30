//
//  ListView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import SwiftUI
import CachedAsyncImage

struct ListView: View {
    
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        GeometryReader(content: { geometry in
            let gridItemWidth = CGFloat((geometry.size.width / 2) - 5)
            let gridItem = GridItem(.fixed(gridItemWidth))
            
            ScrollView {
                LazyVGrid(columns: [gridItem, gridItem]) {
                    ForEach(viewModel.pokemons) { pokemon in
                        VStack {
                            CachedAsyncImage(url: URL(string: pokemon.sprites.frontDefault))
                                
                            Text(pokemon.name)
                                .foregroundStyle(.white)
                                .padding(.bottom)
                        }
                        .frame(width: gridItemWidth)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.red)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


