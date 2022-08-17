//
//  FavoritesRepository.swift
//  TheForkTest
//
//  Created by Max Ward on 17/08/2022.
//

import Foundation

protocol FavoritesRepository {
    func loadFavorites() async -> [String]
    func removeFromFavorites()
    func addToFavorites()
    func getWithContent(_ uuid: String)
}
