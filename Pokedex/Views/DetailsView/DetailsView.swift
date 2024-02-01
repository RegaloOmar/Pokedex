//
//  DetailsView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 31/01/24.
//

import SwiftUI
import SwiftData

struct DetailsView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \PokemonModel.id) var pokemonsModel: [PokemonModel]
    @State var isFavorite: Bool
    @StateObject private var viewModel: DetailsViewModel = DetailsViewModel()
    
    var pokemon: PokemonData
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { phase in
                    switch phase {
                        case .empty:
                            EmptyView()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 200, height: 200, alignment: .center)
                        case .failure(_):
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                    }
                }
                
                Text("Height: " + String(pokemon.height))
                    .font(.title)
                    .bold()
                    .padding()
                
                Text("Base XP: " + String(pokemon.baseExperience))
                    .font(.system(.title))
                    .bold()
                    .padding(.bottom)
                
                HStack {
                    Text("Moves:")
                        .font(.system(.title2))
                        .bold()
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyHGrid(rows: [GridItem(.fixed(50), spacing: 10, alignment: .topLeading),
                                 GridItem(.fixed(50), spacing: 10, alignment: .topLeading)]) {
                    ForEach(pokemon.abilities, id: \.self) { abilityList in
                        Text(abilityList.ability.name.capitalized)
                            .font(.system(.title))
                            .bold()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(viewModel.getBackgroundColor(from: pokemon.types.first!))
                                    .padding(.horizontal, -5)
                            }
                    }
                }
                
                HStack {
                    Text("Pokemon Type:")
                        .font(.system(.title2))
                        .bold()
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyHGrid(rows: [GridItem(.fixed(50), spacing: 10, alignment: .center)]) {
                    ForEach(pokemon.types, id: \.self) { typeList in
                        Text(typeList.type.name.capitalized)
                            .font(.title)
                            .bold()
                            .foregroundStyle(viewModel.getBackgroundColor(from: typeList))
                    }
                }
                
                Spacer()
            }
            .toolbar {
                Button(action: {
                    if isFavorite == false {
                        isFavorite.toggle()
                        let favoritePokemon = PokemonModel(id: pokemon.id,
                                                           name: pokemon.name,
                                                           baseExperience: pokemon.baseExperience,
                                                           height: pokemon.height,
                                                           sprites: pokemon.sprites,
                                                           abilities: pokemon.abilities,
                                                           types: pokemon.types, isFavorite: isFavorite)
                        withAnimation {
                            modelContext.insert(favoritePokemon)
                            try? modelContext.save()
                        }
                    } else {
                        let favoritePokemon = PokemonModel(id: pokemon.id,
                                                           name: pokemon.name,
                                                           baseExperience: pokemon.baseExperience,
                                                           height: pokemon.height,
                                                           sprites: pokemon.sprites,
                                                           abilities: pokemon.abilities,
                                                           types: pokemon.types,
                                                           isFavorite: isFavorite)
                        isFavorite.toggle()
                        withAnimation {
                            modelContext.delete(favoritePokemon)
                        }
                        try? modelContext.save()
                    }
                    
                    
                }, label: {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundStyle(Color("pokemonElectric", bundle: nil))
                    .hidden()
                })
            }
            .navigationTitle(pokemon.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DetailsView(isFavorite: true,
                pokemon: PokemonData(id: 1,
                                     name: "Pikachu",
                                     baseExperience: 100,
                                     height: 24,
                                     isDefault: true,
                                     abilities: [Abilities(isHidden: false,
                                                           slot: 1,
                                                           ability: PokemonList(name: "Cut",
                                                                                url: "")),
                                                 Abilities(isHidden: false,
                                                           slot: 1,
                                                           ability: PokemonList(name: "Tunder",
                                                                                url: ""))],
                                     sprites: Sprites.init(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"),
                                     types: [Types.init(slot: 1,
                                                        type: PokemonList(name: "Electric",
                                                                          url: ""))]))
}
