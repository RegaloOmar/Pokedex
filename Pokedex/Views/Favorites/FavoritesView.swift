//
//  FavoritesView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 30/01/24.
//

import SwiftUI
import CachedAsyncImage

struct FavoritesView: View {
    
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        GeometryReader(content: { geometry in
            let gridItemWidth = CGFloat(geometry.size.width)
            let gridItem = GridItem(.fixed(gridItemWidth))
            
            ScrollView {
                LazyVGrid(columns: [gridItem]) {
                    ForEach(viewModel.pokemons) { pokemon in
                        HStack {
                            
                            VStack {
                                CachedAsyncImage(url: URL(string: pokemon.sprites.frontDefault))
                                    .padding(.bottom, -15)
                                
                                Text(pokemon.name.capitalized)
                                    .font(.system(.headline))
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 10)
                                
                            }
                            VStack {
                                Text("Height: " + String(pokemon.height))
                                    .foregroundStyle(.white)
                                
                                Text("Pokedex: " + String(pokemon.id))
                                    .foregroundStyle(.white)
                                
                                
                                    
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .frame(width: gridItemWidth)
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(viewModel.getBackgroundColor(from: pokemon.types))
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .onAppear {
                    Task {
                        await viewModel.fetchPokemonList()
                    }
                }
            }
        })
        .padding(10)
       
    }
}

#Preview {
    FavoritesView()
}
