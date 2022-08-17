//
//  FavoritesRepositoryDefault.swift
//  TheForkTest
//
//  Created by Max Ward on 17/08/2022.
//

import Foundation

class FavoritesRepositoryDefault: FavoritesRepository {
    func loadFavorites() async -> [String] {
        do {
            guard let favorites = try await CoreDataStack.shared.fetch(Favorites.fetchRequest()) else {
                return []
            }
            return favorites.map { item in
                item.uuid
            }
            
        } catch {
            return []
        }
    }
    
    func removeFromFavorites() {}
    
    func addToFavorites() {}
    
    func getWithContent(_ uuid: String) {
        
    }
    
    
}
