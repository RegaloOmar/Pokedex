//
//  ListView.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    
    @StateObject private var viewModel = ListViewModel()
    @State private var isFavorite: Bool = false
    @State private var isLoading: Bool = true
    
    var body: some View {
        NavigationStack {
            GeometryReader(content: { geometry in
                ZStack {
                    if isLoading {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                        ProgressView()
                    } else {
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
                                        .onAppear{
                                            if pokemon.name == viewModel.pokemons.last?.name {
                                                Task {
                                                    await viewModel.fetchMorePokemons()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                .onAppear {
                    if viewModel.pokemons.count == 0 {
                        Task {
                            isLoading = true
                            await viewModel.fetchPokemonList()
                            isLoading = false
                        }
                    }
                }
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
            AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { phase in
                switch phase {
                    case .empty:
                        EmptyView()
                    case .success(let image):
                        image
                    case .failure(_):
                        Image("pokeball")
                            .resizable()
                            .frame(width: 50, 
                                   height: 50)
                            .padding()
                    @unknown default:
                        ProgressView()
                            .frame(width: 50,
                                   height: 50)
                }
            }
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
