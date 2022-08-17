//
//  HomeInteractor.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {
    
    private var presenter: HomePresenterProtocol?
    
    let worker: RestaurantWorker
    
    init(presenter: HomePresenterProtocol, worker: RestaurantWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func getFavorites() {
        Task {
            let favorites = await worker.getFavorites()
            self.presenter?.handleFavSuccessResponse(favorites)
        }
    }
    
    func getRestaurants() {
        Task {
            let restaurants = await worker.getRestaurants()
            self.presenter?.handleSuccessResponse(restaurants)
        }
    }
    
    func sortRestaurantsByName(_ restaurants: [Restaurant]) {
        let sortedRestaurantList = restaurants.sorted { lhs, rhs in
            return lhs.name < rhs.name
        }
        self.presenter?.handleSuccessResponse(sortedRestaurantList)
    }
    
    func sortRestaurantsByRate(_ restaurants: [Restaurant]) {
        let sortedRestaurantList = restaurants.sorted { lhs, rhs in
            return lhs.rating > rhs.rating
        }
        self.presenter?.handleSuccessResponse(sortedRestaurantList)
    }
    
    func saveOrRemoveAsFavorite(_ restaurant: Restaurant) async {
        let favorites = await worker.getFavorites()
        if favorites.contains(restaurant.uuid) {
            await worker.removeFavorite(restaurant)
            self.getFavorites()
        } else {
            await worker.addFavorite(restaurant)
            self.getFavorites()
        }
    }
}
