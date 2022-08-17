//
//  HomeModuleBuilder.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import Foundation

protocol HomeViewProtocol {
    func updateContent(_ restaurante: [Restaurant])
    func updateFavorites(_ favorites: [String])
    func showError(message: String)
}

protocol HomeInteractorProtocol {
    func getRestaurants()
    func getFavorites()
    func sortRestaurantsByName(_ restaurants: [Restaurant])
    func sortRestaurantsByRate(_ restaurants: [Restaurant])
    func saveOrRemoveAsFavorite(_ restaurant: Restaurant) async
}

protocol HomePresenterProtocol {
    func handleSuccessResponse(_ restaurants: [Restaurant])
    func handleFavSuccessResponse(_ favorites: [String])
    func handleFailure(message: String)
}

class HomeModuleBuilder {
    func build() -> HomeViewController {
        let worker = RestaurantWorkerDefault()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let view = HomeViewController(interactor: interactor)
        
        presenter.view = view
        
        return view
    }
}
