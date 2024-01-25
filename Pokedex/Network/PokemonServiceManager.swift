//
//  PokemonServiceManager.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import Foundation

protocol PokemonServiceManagerProtocol {
    func fetchPokemonList() async throws -> RootInfo
}


class PokemonServiceManager: PokemonServiceManagerProtocol {
    
    enum APIError: Error {
            case invalidURL
            case networkError(Error)
            case invalidResponse
        }
    
    func fetchPokemonList() async throws -> RootInfo {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0") else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let responseHTTP = response as? HTTPURLResponse,
                  responseHTTP.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            let decodedResponse = try JSONDecoder().decode(RootInfo.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.networkError(error)
        }
    }
}

struct ServiceEndPoints {
    static let baseListURL = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
}
