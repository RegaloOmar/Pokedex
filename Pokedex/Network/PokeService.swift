//
//  PokeService.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 23/01/24.
//

import Foundation


class PokeService {
    
    private var baseURLComponents: URLComponents {
        var components = ServiceEndPoints.baseURLComponents
        components.path = "/api/v2/"
        return components
    }
}

struct ServiceEndPoints {
    static var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pokeapi.co"
        return components
    }
}
