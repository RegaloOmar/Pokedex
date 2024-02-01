//
//  FavoritesView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 30/01/24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \PokemonModel.id) var pokemonsModel: [PokemonModel]
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        GeometryReader(content: { geometry in
            let gridItemWidth = CGFloat(geometry.size.width)
            let gridItem = GridItem(.fixed(gridItemWidth))
            
            ScrollView {
                LazyVGrid(columns: [gridItem]) {
                    ForEach(pokemonsModel) { pokemon in
                        HStack {
                            
                            VStack {
                                AsyncImage(url: URL(string: pokemon.sprites.frontDefault))
                                    .padding(.bottom, -15)
                                
                                Text(pokemon.name.capitalized)
                                    .font(.system(.headline))
                                    .foregroundStyle(.white)
                                    .padding(.bottom, 10)
                                
                            }
                            
                            VStack(alignment: .leading, spacing: 10.0) {
                                Text("Height: " + String(pokemon.height))
                                    .foregroundStyle(.white)
                                
                                Text("Pokedex: " + String(pokemon.id))
                                    .foregroundStyle(.white)
                                
                                Text("Base XP: " + String(pokemon.baseExperience))
                                    .foregroundStyle(.white)
                            }
                            
                            
                           LazyVGrid(columns: [GridItem(.fixed(70))]) {
                               ForEach(pokemon.types, id: \.self) { typeList in
                                   Text(typeList.type.name.capitalized)
                                       .foregroundStyle(.white)
                                       .bold()
                               }
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
            }
        })
        .padding(10)
       
    }
}

#Preview {
    FavoritesView()
}
