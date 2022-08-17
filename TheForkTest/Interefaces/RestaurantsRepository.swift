//
//  RestaurantsRepository.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

protocol RestaurantRepository {
    func fetch() async throws -> [Restaurant]?
}

protocol FavoritesRepository {
    func loadFavorites() async -> [String]
    func removeFromFavorites()
    func addToFavorites()
    func getWithContent(_ uuid: String)
}
