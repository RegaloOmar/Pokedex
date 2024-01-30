//
//  URLCache.swift
//  Pokedex
//
//  Created by Omar Regalado Mendoza on 30/01/24.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
