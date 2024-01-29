//
//  PokemonServiceManager.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import Foundation

protocol PokemonServiceManagerProtocol {
    func fetchRootInfo() async throws -> RootInfo
    func fetchPokemonData(pokemonURL: String) async throws -> Pokemon
}


class PokemonServiceManager: PokemonServiceManagerProtocol {
    
    public enum APIError: Error {
        case invalidURL
        case networkError(Error)
        case invalidResponse
    }
    
    func fetchRootInfo() async throws -> RootInfo {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0") else {
            throw APIError.invalidURL
        }
        
        do {
            return try await execute(url: url, dataType: RootInfo.self)
        } catch (let error) {
            throw APIError.networkError(error)
        }
    }
    
    func fetchPokemonData(pokemonURL: String) async throws -> Pokemon {
        guard let url = URL(string: pokemonURL) else {
            throw APIError.invalidURL
        }
        do {
            return try await execute(url: url, dataType: Pokemon.self)
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

struct ServiceEndPoints {
    static let baseListURL = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
}
