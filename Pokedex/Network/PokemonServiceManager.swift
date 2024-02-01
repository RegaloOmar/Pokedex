//
//  PokemonServiceManager.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import Foundation

protocol PokemonServiceManagerProtocol {
    typealias PokemonResponse = (next: String?, pokemons: [PokemonData])
    
    func fetchPokemonData() async throws -> PokemonResponse
}


class PokemonServiceManager: PokemonServiceManagerProtocol {
    
    enum APIError: Error {
        case invalidURL
        case networkError(Error)
        case invalidResponse
    }
    
    func fetchPokemonData() async throws -> PokemonResponse {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=50&offset=0") else {
            throw APIError.invalidURL
        }
        
        do {
            let rootInfo = try await execute(url: url, dataType: RootInfo.self)
            var pokemonList: [PokemonData] = []
            for result in rootInfo.results {
                do {
                    let pokemon = try await fetchPokemonData(pokemonURL: result.url)
                    pokemonList.append(pokemon)
                } catch {
                    throw APIError.invalidResponse
                }
            }
            return (rootInfo.next, pokemonList)
        } catch (let error) {
            throw APIError.networkError(error)
        }
    }
    
    func fetchPokemonData(pokemonURL: String) async throws -> PokemonData {
        guard let url = URL(string: pokemonURL) else {
            throw APIError.invalidURL
        }
        do {
            return try await execute(url: url, dataType: PokemonData.self)
        } catch (let error) {
            throw APIError.networkError(error)
        }
    }
    
    func execute<T: Codable>(url: URL, dataType: T.Type) async throws -> T{
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let responseHTTP = response as? HTTPURLResponse,
              responseHTTP.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        let decodedResponse = try JSONDecoder().decode(dataType.self, from: data)
        return decodedResponse
    }
}
