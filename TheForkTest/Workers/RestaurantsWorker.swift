//
//  RestaurantsWorker.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

protocol RestaurantWorker: AnyObject {
    func getRestaurants() async -> [Restaurant]
    func addFavorite(_ restaurant: Restaurant) async
    func removeFavorite(_ restaurant: Restaurant) async
    func getFavorites() async -> [String]
}

class RestaurantWorkerDefault: RestaurantWorker {
    
    private var repository: RestaurantRepository = RestaurantRepositoryDefault()
    private var favoritesRepository: FavoritesRepository = FavoritesRepositoryDefault()
    
    func getRestaurants() async -> [Restaurant] {
        do {
            guard let restaurants = try await repository.fetch() else { return [] }
            return restaurants
        } catch {
            return []
        }
    }
    
    func addFavorite(_ restaurant: Restaurant) async {
        let favorite = Favorites(context: CoreDataStack.shared.context)
        favorite.uuid = restaurant.uuid
        let _ = try? await CoreDataStack.shared.saveContext()
    }
    
    func removeFavorite(_ restaurant: Restaurant) async {
        let results = try? await CoreDataStack.shared.fetch(Favorites.fetchRequest())
        results?.forEach({ favorite in
            if favorite.uuid == restaurant.uuid {
                CoreDataStack.shared.context.delete(favorite)
            }
        })
        try! await CoreDataStack.shared.saveContext()
    }
    
    func getFavorites() async -> [String] {
        let favorites = await favoritesRepository.loadFavorites()
        return favorites
    }    
}
